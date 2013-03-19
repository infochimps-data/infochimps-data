
pairs.annot <- function(data, ...) {
  
  panel.lm <- function (x, y, col = par("col"), bg = NA, pch = par("pch"),
                        cex = 1, col.lm = "red", lwd=par("lwd"), ...) {
    points(x, y, pch = pch, col = col, bg = bg, cex = cex)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok))
      abline(lm(y~x,subset=ok), col = col.lm, ...)
  }
  
  panel.sse<-
    function(y, x, digits=2)
    {
      usr <- par("usr"); on.exit(par(usr))
      par(usr = c(0, 1, 0, 1))
      
      model <- summary(lm(y~x))
      r2<- model$r.squared
      r<-sqrt(r2)*sign(model$coef[2,1])
      # p<- model$coef[2,4]
      
      txt <- round(r, digits)
      txt <- bquote(r == .(txt))
      text(0.5, 0.7, txt, cex=1.5)
      
      txt <- round(r2, digits)
      txt <- bquote(r^2 == .(txt))
      text(0.5, 0.5, txt, cex=1.5)
      
      # txt <- round(p, digits)
      # txt <- bquote(P == .(txt))
      # text(0.5, 0.3, txt, cex=1.5)
    }
  
  pairs(data,lower.panel=panel.sse,upper.panel=panel.lm)
}
