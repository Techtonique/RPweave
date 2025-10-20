# Auto-configure Python when project loads
if (requireNamespace("reticulate", quietly = TRUE)) {
  if (file.exists("venv/bin/python")) {
    reticulate::use_python("venv/bin/python")
    cat("Using project virtual environment\n")
  } else if (Sys.which("python") != "") {
    cat("Using system Python\n")
  }
}