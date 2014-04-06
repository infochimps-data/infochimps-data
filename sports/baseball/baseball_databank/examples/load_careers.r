library(reshape2)
library(plyr)
library("RMySQL", lib.loc="/Library/Frameworks/R.framework/Versions/2.15/Resources/library")
library(Matrix)
library(ggplot2)
# library(GGally)

mysqlc <- dbConnect(MySQL(), user="root", dbname="baseball")

req  <- dbSendQuery(mysqlc, "select
  playerID, nameCommon,
  g,
  -- g_batting, g_pitching, g_allstar,
  pa, ab, r, h, 2b as x2b, 3b as x3b, hr, rbi, sb, bb, so,
  -- ibb, hbp, sf, gidp, 
  bavg, tb, slg, obp, iso,
  -- w, l, cg, sv, ipouts, ha, ra, er, hra, bba, soa,
  -- era, whip, h_9, hr_9, bb_9, so_9, so_bb,
  war, war_off, war_def, war_pit,
  birthyear, weight, height, bats
  FROM career_all WHERE (PA > 250) -- AND (g_allstar >= 1) 
  ")
careers <- fetch(req, n=20000)
huh     <- dbHasCompleted(req) ; dbClearResult(req) ; dbDisconnect(mysqlc)

# convert NA to 0 
careers[is.na(careers)] <- 0

# 'equivalent seasons' -- 502 plate appearances 
careers$eqseasons = careers$pa / 502

mapstr <- function(strvec, s2){ aaply(strvec, 1, function(str){ paste(str, s2, sep='') }) }
id_cols         <- c('playerID', 'nameCommon')
ratelike_cols   <- c(     'h', 'x2b', 'x3b', 'hr', 'sb', 'so')
feature_cols    <- c('g', 'h', 'x2b', 'x3b', 'hr', 'sb', 'so', 'slg', 'weight', 'height')
# rate_cols     <- mapstr( ratelike_cols, 'rt' )
# scaled_cols   <- mapstr( scaled_cols,   'sc' )
 
pl_rates        <- careers[unlist(c(id_cols, 'pa', 'eqseasons', feature_cols))]
pl_scrts        <- careers[unlist(c(id_cols, 'pa', 'eqseasons', feature_cols))]

pl_rates[ratelike_cols] <- careers[ratelike_cols] / careers$eqseasons
pl_scrts[feature_cols]  <- colwise(scale)(pl_rates[feature_cols])

# 
# # matricize players
# pmat <- matrix(unlist(players), ncol=length(players), byrow=FALSE)
# 
# # Normalize to seasons using nominal 502 PA / season ; 162 IP (486 IPout) / season
# # pmean <- colMeans(players)
# # psdev <- sapply(players, sd)
# 
# z_players <- t((t(players) - pmean) / psdev)
# 
# # or could use apply t(apply( t(apply(players,1,'-',pmean) ), 1,'/',psdev))
# # double check: ((z_players[1,] * psdev) + pmean) - players[1,]
# #    round(t((t(z_players) * psdev) + pmean) - players, 12)
# 
# # svd of players
# psvd <- svd(z_players)
# 
# # where to truncate SVD
# kdims <- 3
# 
# psvd_dvec <- psvd$d
# psvd_umat <- psvd$u[,1:kdims]
# psvd_dmat <- Diagonal(length(psvd$d), psvd$d)
# psvd_vmat <- psvd$v[1:kdims,]
# sgr <- (psvd_umat %*% psvd_dmat[1:kdims,1:kdims] %*% psvd_vmat)
# 
# vsigns <- psvd_vmat ; vsigns[psvd_vmat > 0] <- 1 ; vsigns[psvd_vmat < 0] <- -1 ;
# usigns <- psvd_umat ; usigns[psvd_umat > 0] <- 1 ; usigns[psvd_umat < 0] <- -1 ;
# 
# vs_colorder <- do.call(order, lapply(1:NROW(vsigns), function(i) vsigns[i, ]))
# us_colorder <- do.call(order, lapply(1:NROW(usigns), function(i) usigns[i, ]))
# 
# # # you can tell how many dims to use by where psvd_dvec falls off:
# # psvd_dvec[1:12]
# 
# # first 5 components of first three players (I think?)
# coords35 <- pmat[1:3,] %*% t(psvd$v[1:5,])
# 
# p_p_dot <- pmat %*% t(pmat)

