## Resubmission 

This is a resubmission. The previous submission raised-- 

- We see examples wrapped in if(FALSE){}. Please never do that. If the
example cannot be executed (e.g. because of missing additional software,
missing API keys, ...) by the user it should be wrapped in \dontrun{}.
Lengthy examples (> 5 sec) in \donttest{}.

I've removed all `@examplesIf` tags and placed the examples in \dontrun{}.

## Resubmission 

This is a resubmission. The previous submission raised-- 

- It is bad practice to cite a book by providing links to a shop.

This link has been removed.

## Resubmission

This is a resubmission. The previous submission raised-- 

- Missing Rd-tags:
      pipe.Rd: \value

This issue has now been fixed.

## Resubmission

This is a resubmission. The previous submission raised-- 

- Unexecutable code in man/only_if.Rd:
   d %>%:

- Please ensure that your functions do not write by default or in your 
examples/vignettes/tests in the user's home filespace (including the 
package directory and getwd()) -> man/ggsave2.Rd

- Please always make sure to reset to user's options(), working directory 
or par() after you changed it in examples and vignettes and demos.
-> inst/doc/plotting.R

These issues have now been fixed.


## Resubmission

This is a resubmission. The previous submission raised-- 
   Check: Rd cross-references, Result: NOTE
   Found the following Rd file(s) with Rd \link{} targets missing package
   anchors:
     ratlas-ggproto.Rd: ggproto
     scale_atlas.Rd: discrete_scale
     scale_lcrost.Rd: discrete_scale
     scale_okabeito.Rd: discrete_scale
   Please provide package anchors for all Rd \link{} targets not in the
   package itself and the base packages.

Those links have now been fixed with the appropriate package anchors.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
