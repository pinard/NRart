\name{NRart}
\alias{NRart}
\alias{nr.image}
\alias{nr.movie}
\title{NRart Newton-Raphson art}
\description{
  Produce 2-D images or movies out of mathematical functions.

  To to so, apply a few iterations of Newton-Raphson method to each
  point of a complex plane.
}
\usage{
  nr.image(expr, centre = c(0, 0), zoom = 1,
           xrange=c(centre[1]-zoom, centre[1]+zoom),
           yrange=c(centre[2]-zoom, centre[2]+zoom),
           points = 150, steps = 5, each, display = image,
           main = deparse(substitute(expr)), ...)
  nr.movie(expr, time.name, time.values, ...)
}
\arguments{
  \item{expr}{Symbolic expression of the mathematical function to render}
  \item{centre}{Vector for the coordinates of grid centre}
  \item{zoom}{Domain interval from \code{centre} to grid side}
  \item{xrange}{Vector giving minimum and maximum real parts for the grid}
  \item{yrange}{Vector giving minimum and maximum imaginary parts for the grid}
  \item{points}{Number of points along grid side}
  \item{steps}{Number of Newton-Raphson iterations}
  \item{each}{Frequency, in steps, for producing intermediate images}
  \item{display}{Function producing one image}
  \item{main}{Image title}
  \item{time.name}{String giving the animation parameter within \code{expr}}
  \item{time.values}{Vector of values to be taken by the animation parameter}
  \item{\dots}{Options being transmitted down to sub-functions}
}
\details{
  These functions apply one or more Newton-Raphson iteration steps to
  \code{expr}, as a way of approaching roots (or zeroes) of the represented
  mathematical function.

  The first argument \code{expr} is the mathematical formula, the one
  for which we are seeking zeroes.  That expression should use only one
  \dQuote{unknown} variable (for \code{nr.image}) or one unknown and one
  parameter (for \code{nr.movie}).  It should be symbolically derivable
  respective to its unknown.

  Produced images or movies represent a square region in the complex
  plane, having a side of \eqn{2*zoom} and centred on the origin, by
  default.  Increasing \code{zoom} over one zooms out, decreasing it
  towards zero zooms in.  Instead of specifying \code{centre} and
  \code{zoom}, one may explicit \code{xrange} and \code{yrange}, in
  which case the represented region is not necessarily square.

  That region is to be displayed as \eqn{points^2} pixels.  So,
  \code{points} gives the number of points in the horizontal or vertical
  directions.  While playing with the formula and doing quick testing, a
  lower value for \code{points} makes the rendering much speedier, but
  the result is also more rough.  Make it a few hundreds for the final
  pass.

  There are \code{steps} Newton-Raphson iterations for each pixel
  before producing the frame.  More steps yield more precision, and a
  better classification of points toward their associate root.  So,
  a higher value for \code{steps} translates into crisper or sharper
  boundaries between colours.  A low value has the effect of producing
  more progressive (or \dQuote{ramp}ed) transitions between colors.

  If \code{each} has been provided, an intermediate image is produced at
  every \code{each} steps.  Using \samp{each=1}, say, \code{nr.image}
  shows the progressive sharpening of the resolution by displaying each
  step, while Newton-Raphson iterations go and fractals develop.

  For \code{nr.movie}, option \code{time.name} is a string naming the
  parameter in the mathematical formula, and \code{time.values} gives
  the successive values taken by this parameter for each produced movie
  frame, thus producing the animation.  For the animation to endlessly
  repeat in a smooth way, the formula should be periodic over its
  parameter, and one should be careful to exclude the last frame if it
  were to be equal to the first.  For example, for 120 animation frames
  over a \eqn{\pi}{pi} period, one may use \samp{time.values=seq(0, pi,
  length=121)[-1]}.

  By default, the \code{image} function is used to display the
  result, but this can be changed using the \code{display} option for
  any function accepting a matrix of floating values.  Internally,
  \code{nr.image} (which is also called by the others) uses \code{Arg}
  for turning complex values into floating values before calling the
  displaying function.
}
\value{
  Functions return the final matrix of complex numbers.
}
\note{

  The basic idea is simple.
  \itemize{
    \item
      The equation \eqn{f(x) = 0} has one or many solutions, which
      may be real or complex numbers.  A polynomial of degree \eqn{N}
      has exactly \eqn{N} solutions (yet, as some solutions may coincide,
      people might prefer to say that such a polynomial has at least 1,
      and at most \eqn{N} solutions).
    \item
      There are really many ways to seek out for zeroes of a mathematical
      function, and each method opens the door to various pictures which may
      be visually interesting.  The Newton-Raphson is simple and well known,
      and productive enough already, artistically speaking!
    \item
      Starting from a point in the complex plane, Newton-Raphson method
      may diverge, oscillate, or converge.  When it converges, it is towards
      one of the root for the function.  Different starting points may yield
      different roots.  If we associate one colour to each possible
      root, one may also colour any starting point with the colour of root
      yielded by that point, or let the point uncoloured if there is no
      convergence.
  }

  The boundary between colours really often (but not always) has fractal
  nature.  For exploring such boundaries, you may need to compute
  really many points, and many Newton-Raphson iterations, so it may be
  computationally intensive.

  A few problems arise when one wants to colour points, however:

  \itemize{
    \item
      The number of solutions is not always known in advance, when one
      escapes the realm of polynomials.  So, one may not always fix a
      colour palette before starting computing everything.
    \item
      The number of Newton-Raphson iterations to decide convergence, and
      identify the convergence point, is not always small, even if usually.
  }

  As all points of the complex plane more or less collapse around roots,
  which are limiting values, the problem might be the attribution of
  colours for any complex value.  Then, as iterations go, colours of
  the complex plane will collapse into regions surrounding roots, which
  are then limiting colours for the convergence process.  Under this
  approach, we can have displayable results without computing much, and
  more computation will then increase the sharpness of colour separation.

  To produce a smooth animation, one may inject a parameter in the
  mathematical formula, and then vary the parameter value in a smooth way.

  \code{nr.image} is called by \code{nr.movie} under the scene, it
  computes real arguments (angles) over a matrix of complex numbers, and
  then associate colours to various range of real values (the algorithm
  could have used other complex to real mappings just as well, yet the
  package does not offer that flexibility as it stands).  Arguments
  theoretically go from \eqn{-\pi}{-pi} to \eqn{+\pi}{+pi}.  This may be
  the source of a few problems:

  \itemize{
    \item
      Using arguments means that if two roots are aligned as seen
      from the origin (they have the same angle), they will have the same
      colour and so, will not be distinguished in the produced display.
    \item
      Some frames of the animation may use only part of that range,
      and not always the same part: the \code{image} function should
      not itself decide the mapping of values to colours from a
      variable range from frame to frame, it is nicer to have colours
      mapped fixed to values for the whole animation.  An option
      \samp{zlim=c(-pi,pi)}, which gets transmitted down to function
      \code{image}, solves this particular problem.
    \item
      Another possible problem might arise from the fact that
      argument of complex numbers are angles, and \eqn{-\pi}{-pi} and
      \eqn{+\pi}{+pi} \dQuote{touch} each other.  This might create
      sharp transitions in the colouring, which may be either welcome
      or not.  When not, it is better to use a cyclic ramp of colours,
      through an option like \samp{col=rainbow(64)}, which gets
      transmitted down to the \code{image} function.
  }

}
\references{
  This tool was inspired by a conference by Bahaman Kalantari (Rutgers
  University) while visiting Concordia University (Montreal), on 2005-04-05.
  See \url{http://www.polynomiography.com/}.

  A few examples of animations generated with this tool may be seen at
  \url{http://pinard.progiciels-bpi.ca/notes/Animations.html}.

  Others have done similar works, using other languages.  For example,
  see \url{http://www.chiark.greenend.org.uk/~sgtatham/newton/}.
}
\author{Francois Pinard \email{pinard@iro.umontreal.ca}}
\seealso{
  \code{\link[stats]{deriv}}
  \code{\link[graphics]{image}}
}
\examples{
  nr.image(x^3 - sqrt(x) - 1, points=300)
  nr.image(x^3 - sqrt(x) - 1, steps=6, points=50, display=filled.contour)
  nr.movie(x^3 - time, 'time', 1:5, steps=3, col=rainbow(15))
}
\keyword{dynamic}
