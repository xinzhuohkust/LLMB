.onLoad <- \(libname, pkgname) {

  cryptojs_env <- new.env(parent = emptyenv())


  cryptojs_env$engine <- V8::v8()

  cryptojs_env$engine$source(system.file("js/crypto-js.js", package = pkgname))

  cryptojs_env$engine$source(system.file("js/crypto-js.js", package = pkgname))

  cryptojs_env$signature <- purrr::possibly(
    \(json, url = "/v2/threads/search?sortType=0") {
      cryptojs_env$engine$eval(sprintf('var e = "%s";', url))
      cryptojs_env$engine$call("generate_signature", json)
    },
    otherwise = \(error) message("\tload signature functions failed: ", error)
  )

  cryptojs_env$json_to_tibble <- \(x) {
    httr2::resp_body_json(x) |>
      purrr::pluck("data", "data") |>
      purrr::map_dfr(tibble::as_tibble) |>
      dplyr::mutate(dplyr::across(dplyr::contains("Date"), ~ as.POSIXct(., origin = "1970-01-01", tz = "Asia/Shanghai")))
  }

  ns <- asNamespace(pkgname)

  assign(".cryptojs_env", cryptojs_env, envir = ns)

  message("crypto-js has been loaded into R.")
}

