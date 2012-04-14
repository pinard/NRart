"nr.movie" <-
function(expr, time.name, time.values,
         main=deparse(substitute(expr)), ...)
{
    call <- match.call(expand.dots=FALSE)
    expr = substitute(expr)
    vars = list()
    for (value in time.values) {
        vars[[time.name]] = value
        .expr <- eval(substitute(substitute(.x, .v), list(.x=expr, .v=vars)))
        .call <- c(as.name('nr.image'), as.expression(.expr), main='', call$...)
        eval.parent(as.call(.call))
        title(main)
        mtext(paste(time.name, '=', format(value, digits=5)),
              side=1, line=2, font=2, adj=.1)
    }
}

