#' Internal Function
#'
#' This is not to be used directly by the users.
#'
#' @export
#' @importFrom httr GET write_disk content
#' @importFrom purrr map
#' @keywords internal
#'
load_imported_data <- function(casestudy){

  # getting repo webpage data
  repo_url = paste0("https://api.github.com/repos/opencasestudies/",
                    casestudy, "/git/trees/master?recursive=1") # creating repo url string
  repo = GET(url=repo_url)
  repocont = content(repo)
  repounlist = unlist(repocont, recursive = FALSE)
  paths = map(repounlist,'path') # creating list of just the file paths in the repo
  paths = paths[!sapply(paths,is.null)] # removing null values

  for (fname in paths){
    if (grepl('data/', fname, fixed = TRUE)) { # if file is in the data directory
      if (grepl('/imported/', fname, fixed = TRUE)) {

        githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

        if (grepl('.rda', fname, fixed = TRUE)) { # if .rda file

          # load the r object into the global environment from the .rda file link
          load(url(githuburl), envir = globalenv())
        }
      }
    }
  }
}
