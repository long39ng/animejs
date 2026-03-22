bump_widget_version <- function(
  desc_path = "DESCRIPTION",
  yaml_path = "inst/htmlwidgets/animejs.yaml",
  binding_name = "animejs-binding"
) {
  version <- as.character(read.dcf(desc_path)[, "Version"])

  yaml_lines <- readLines(yaml_path, warn = FALSE)

  name_line <- grep(
    paste0("name:\\s*", binding_name),
    yaml_lines,
    perl = TRUE
  )

  if (length(name_line) == 0) {
    stop(sprintf(
      "No dependency named '%s' found in %s",
      binding_name,
      yaml_path
    ))
  }

  version_line <- name_line + 1
  if (!grepl("^\\s*version:", yaml_lines[version_line])) {
    stop(sprintf(
      "Expected a version: line at line %d of %s but found: %s",
      version_line,
      yaml_path,
      yaml_lines[version_line]
    ))
  }

  old_line <- yaml_lines[version_line]
  yaml_lines[version_line] <- sub(
    "(?<=version:\\s).*",
    version,
    yaml_lines[version_line],
    perl = TRUE
  )

  if (yaml_lines[version_line] == old_line) {
    message("Version already up to date: ", version)
    return(invisible(version))
  }

  writeLines(yaml_lines, yaml_path)
  message(sprintf(
    "Updated %s: %s -> %s",
    yaml_path,
    trimws(old_line),
    yaml_lines[version_line]
  ))
  invisible(version)
}
