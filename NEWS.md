# OCSdata 1.1.0

* Added a `NEWS.md` file to track changes to the package.
* Updated the package functions to be able to work with new case studies. 
  * The package functions implement an error check that verifies if the case study repository name input by the user is  valid repository name. The functions do this by checking the input against a list of valid case study repository names. If the input does not match one of the names in the list, the function returns an error message that the `casestudy` input was invalid. 
  * Previously, this list was defined statically and created using the combine `c()` function on several character strings containing each case study repository name. This would require an update to the list in each package function every time a new case study is created. 
  * In version 1.1.0, the list is now created by scraping the list of repository names from [github.com/opencasestudies](https://github.com/opencasestudies) using the [`gh`](https://github.com/r-lib/gh) package. Now, the functions will work with any repository from the Open Case Studies GitHub. However, using the data functions won't do anything with repositories that do not have a `/data/` sub-folder. This will allow the package functions to work with any future case study, without requiring an update. 
* Created a Hexsticker for the package.


# OCSdata 1.0.2

* Updated the primary maintainer listed in DESCRIPTION to [Carrie Wright](https://github.com/carriewright11).
* Added to the package author credentials to include the Open Case Studies creators. 
* Created a [DOI](https://zenodo.org/record/5214347#.Ymsu7NrMLIk) for the package and added DOI, code coverage, and life cycle badges to README. 
* Added more tests to verify proper functionality. 

# OCSdata 1.0.1

* First version of package released to CRAN. 
