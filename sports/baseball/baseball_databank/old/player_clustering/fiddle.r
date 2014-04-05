library(reshape2)
library(plyr)
library("RMySQL", lib.loc="/Library/Frameworks/R.framework/Versions/2.15/Resources/library")
library(Matrix)
library(ggplot2)
# library(GGally)
options(digits=2)

# utilities

chopmat <- function(mat, thresh=1e-12){ apply(mat, c(1,2), function(val){ if(abs(val) < thresh) 0 else val }) }
mapstr  <- function(strvec, s2){ aaply(strvec, 1, function(str){ paste0(str, s2) }) }

#
# Load from MySQL
#
mysqlc <- dbConnect(MySQL(), user="root", dbname="baseball")

# apologies to you, Cap Anson, Pud Galvin, Old Hoss Radbourn and your contemporaries; we'll only include players whose careers extend into the 1900s
req  <- dbSendQuery(mysqlc, "select
  playerID, nameCommon,
  g, begYear, endYear,
  -- g_batting, g_pitching, g_allstar,
  pa, ab, r, h, 2b as x2b, 3b as x3b, hr, rbi, sb, bb, so,
  -- ibb, hbp, sf, gidp, 
  bavg, tb, slg, obp, iso,
  -- w, l, cg, sv, ipouts, ha, ra, er, hra, bba, soa,
  -- era, whip, h_9, hr_9, bb_9, so_9, so_bb,
  war, war_off, war_def, war_pit,
  birthyear, weight, height, bats
  FROM career_all WHERE (birthYear IS NOT NULL) AND (bats IS NOT NULL)
    AND ((isPitcher = 'N') OR (hr > 50))
    AND (endYear > 1900) AND (PA > 250) 
    AND (g_allstar >= 1) 
    -- AND (hofYear IS NOT NULL)
  ")
careers <- fetch(req, n=20000)
huh     <- dbHasCompleted(req) ; dbClearResult(req) ; dbDisconnect(mysqlc)
 

# convert NA to 0 
careers$so[is.na(careers$so)]           <- 0
careers$war_pit[is.na(careers$war_pit)] <- 0
careers$weight[ is.na(careers$weight)]  <- mean(careers$weight[!is.na(careers$weight)])
careers$height[ is.na(careers$height)]  <- mean(careers$height[!is.na(careers$height)])

# 'equivalent seasons' -- 502 plate appearances 
careers$eqseasons = careers$pa / 502

id_cols         <- c('playerID', 'nameCommon')
ratelike_cols   <- c(     'h', 'x2b', 'x3b', 'hr', 'sb', 'so', 'bb')
feature_cols    <- c(     'h', 'x2b', 'x3b', 'hr', 'sb', 'so', 'bb', 'war_def', 'weight') #  'slg', 'height')
# rate_cols     <- mapstr( ratelike_cols, 'rt' )
# scaled_cols   <- mapstr( scaled_cols,   'sc' )
 
pl_rates        <- careers[unlist(c(id_cols, 'pa', 'g', feature_cols, 'obp', 'slg', 'iso'))]
pl_scrts        <- careers[unlist(c(id_cols, 'pa', 'g', feature_cols, 'obp', 'slg', 'iso'))]

# # Normalize to seasons using nominal 502 PA / season ; 162 IP (486 IPout) / season
pl_rates[ratelike_cols] <- careers[ratelike_cols] / careers$eqseasons

# Take Z-scores (`(x-x_avg)/ x_sdev`) of feature columns
pl_scrts[feature_cols]  <- colwise(scale)(pl_rates[feature_cols])

# matricize players
pmat <- matrix(unlist(pl_scrts[feature_cols]), ncol=length(pl_scrts[feature_cols]), byrow=FALSE)

# svd of players
psvd <- svd(pmat)

# you can tell how to set kdims by where the eigenvalues (psvd$d) fall off:
print(c('Significance of dimensions (look for the dropoff):', psvd$d))
# where to truncate SVD
kdims <- 6
# 
psvd_dvec <- psvd$d
psvd_umat <- psvd$u[,1:kdims]
psvd_dmat <- Diagonal(length(psvd$d), psvd$d)
psvd_vmat <- t(psvd$v)[1:kdims,]

reconstituted <- ((psvd_umat %*% psvd_dmat[1:kdims,1:kdims]) %*% psvd_vmat)

 careers[c('q1', 'q2', 'q3', 'q4')] <- pmat %*% psvd$v[,1:4]
pl_rates[c('q1', 'q2', 'q3', 'q4')] <- pmat %*% psvd$v[,1:4]
pl_scrts[c('q1', 'q2', 'q3', 'q4')] <- pmat %*% psvd$v[,1:4]

# stats:::prcomp.default

