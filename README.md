Model Stacking Package
================

[![Codecov test
coverage](https://codecov.io/gh/simonpcouch/stack/branch/main/graph/badge.svg)](https://codecov.io/gh/simonpcouch/stack?branch=main)
[![R build
status](https://github.com/simonpcouch/stack/workflows/R-CMD-check/badge.svg)](https://github.com/simonpcouch/stack/actions)

An R package for model stacking that aligns with the `tidymodels`.

A quick demo of current functionality:

``` r
devtools::load_all()
```

``` r
# initialize the model stack object
st <- stack_init()

st
```

    ## # A model stack with 0 members.
    ## # Evaluated: FALSE

``` r
# add some members
st <- 
  st %>%
  stack_add(svm_res_) %>%
  stack_add(spline_res_)

st
```

    ## # A model stack with 2 members:
    ## #   svm_res_: 5 sub-models
    ## #   spline_res_: 9 sub-models
    ## # Outcome: mpg
    ## # Evaluated: FALSE

``` r
# remove a member
st %>%
  stack_rm("spline_res_")
```

    ## # A model stack with 1 member:
    ## #   svm_res_: 5 sub-models
    ## # Outcome: mpg
    ## # Evaluated: FALSE

``` r
# collate predictions
stacked_data <- st %>%
  stack_data(mtcars)

stacked_data$stacked_data
```

    ## # A tibble: 32 x 15
    ##      mpg Model4 Model5 Model3 Model1 Model2 Recipe1 Recipe4 Recipe7 Recipe2
    ##    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1  21     18.3   18.3   20.5   18.3   22.5    16.9    14.5   20.3     16.3
    ##  2  21     18.3   18.3   20.4   18.3   22.2    16.0    17.4   26.2     17.0
    ##  3  22.8   18.3   18.3   23.8   18.3   26.4    27.6    25.2   22.6     24.0
    ##  4  21.4   18.3   18.3   19.2   18.3   19.7    17.8    12.3    7.76    17.5
    ##  5  18.7   20.1   20.1   16.9   20.1   16.4    17.6    16.2   16.1     16.2
    ##  6  18.1   20.1   20.1   20.1   20.1   20.8    18.8    20.1   16.1     23.5
    ##  7  14.3   20.1   20.1   15.6   20.1   14.0    13.0    13.1   13.4     15.1
    ##  8  24.4   20.1   20.1   22.1   20.1   23.3    20.6    20.5   22.6     23.1
    ##  9  22.8   19.5   19.5   20.8   19.5   20.7    25.4    24.4   24.1     20.6
    ## 10  19.2   18.3   18.3   19.7   18.3   20.0    19.6    19.7   19.3     17.8
    ## # … with 22 more rows, and 5 more variables: Recipe5 <dbl>, Recipe8 <dbl>,
    ## #   Recipe3 <dbl>, Recipe6 <dbl>, Recipe9 <dbl>

``` r
# fit the model using the stacked data
stacked_data %>%
  fit()
```

    ## $coefs
    ## # Tuning results
    ## # Bootstrap sampling 
    ## # A tibble: 25 x 4
    ##    splits          id          .metrics         .notes          
    ##    <list>          <chr>       <list>           <list>          
    ##  1 <split [32/12]> Bootstrap01 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  2 <split [32/14]> Bootstrap02 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  3 <split [32/12]> Bootstrap03 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  4 <split [32/12]> Bootstrap04 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  5 <split [32/11]> Bootstrap05 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  6 <split [32/10]> Bootstrap06 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  7 <split [32/12]> Bootstrap07 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  8 <split [32/11]> Bootstrap08 <tibble [6 × 5]> <tibble [0 × 1]>
    ##  9 <split [32/13]> Bootstrap09 <tibble [6 × 5]> <tibble [0 × 1]>
    ## 10 <split [32/16]> Bootstrap10 <tibble [6 × 5]> <tibble [0 × 1]>
    ## # … with 15 more rows
    ## 
    ## attr(,"class")
    ## [1] "stack_fit" "list"
