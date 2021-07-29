#' Internal Function
#'
#' This is not to be used directly by the users.
#'
#' @export
#' @importFrom httr GET write_disk content
#' @importFrom purrr map
#' @keywords internal
#'
load_extra_data <- function(casestudy, outpath = NULL){
  if (is.null(outpath)) {
    outpath = getwd() # path to working directory
  }
  datapath = file.path(outpath,'data') # path to new data folder directory
  dir.create(datapath, showWarnings = FALSE) # creating data folder

  extrapath = file.path(datapath,'extra') # path to extra data subfolder
  dir.create(extrapath, showWarnings = FALSE)

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
      if (grepl('/extra/', fname, fixed = TRUE)) { # if in extra
        if (grepl('.', fname, fixed = TRUE)) { # if a file

          githuburl = paste0('https://github.com/opencasestudies/', casestudy, '/blob/master/',fname,'?raw=true') # github file link

          # download the file
          GET(githuburl, write_disk(file.path(outpath, fname))) # loading file from url and writing to disk


        } else { # if a directory
          # create sub-folder
          subpath = file.path(outpath, fname)
          dir.create(subpath)

        }
      }
    }
  }
}

