engine <- V8::v8()

engine$source("./inst/js/crypto-js.js")

engine$source("./inst/js/signature.js")

signature <- purrr::possibly(
  \(json, url = "/v2/threads/search?sortType=0") {
    engine$eval(sprintf('var e = "%s";', url))
    engine$call("generate_signature", json)
  },
  otherwise = message("\tload signature functions failed.")
)

json_to_tibble <- \(x) {
  httr2::resp_body_json(x) |>
    purrr::pluck("data", "data") |>
    purrr::map_dfr(tibble::as_tibble) |>
    dplyr::mutate(dplyr::across(dplyr::contains("Date"), ~ as.POSIXct(., origin = "1970-01-01", tz = "Asia/Shanghai")))
}

keyword_search <- purrr::possibly(
  \(keywords = "上访", page = 1, rows = 50, format = "tibble", sleep = sample(seq(1, 2, 0.05), 1)) {
    param <- sprintf(
      '{"position":0,"keywords":"%s","fid":null,"domainId":null,"typeId":null,"timeRange":null,"ansChecked":false,"stTime":null,"sortType":"0","page":%s,"rows":%s}',
      keywords,
      page,
      rows
    )

    result <- "https://liuyan.people.com.cn/v2/threads/search?sortType=0" |>
      httr2::request() |>
      httr2::req_headers(
        `Accept` = "application/json, text/plain, */*",
        `Accept-Language` = "zh-CN",
        `Content-Type` = "application/json;charset=UTF-8",
        `Origin` = "https://liuyan.people.com.cn",
        `Referer` = "https://liuyan.people.com.cn/messageSearch",
        `Sec-Fetch-Dest` = "empty",
        `Sec-Fetch-Mode` = "cors",
        `Sec-Fetch-Site` = "same-origin",
        `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
        `sec-ch-ua` = '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
        `sec-ch-ua-mobile` = "?0",
        `sec-ch-ua-platform` = '"Windows"',
        `token` = ""
      ) |>
      httr2::req_retry(
        max_tries = 3,
        max_seconds = 60,
        backoff = ~5
      ) |>
      httr2::req_body_raw(
        sprintf('{"appCode":"PC42ce3bfa4980a9","token":"","signature":"%s","param":"{\\"position\\":0,\\"keywords\\":\\"%s\\",\\"fid\\":null,\\"domainId\\":null,\\"typeId\\":null,\\"timeRange\\":null,\\"ansChecked\\":false,\\"stTime\\":null,\\"sortType\\":\\"0\\",\\"page\\":%s,\\"rows\\":%s}"}', signature(param), keywords, page, rows)
      ) |>
      httr2::req_perform()

    Sys.sleep(sleep)

    if (httr2::resp_status(result) == 200) {
      switch(format,
        "string" = httr2::resp_body_string(result),
        "tibble" = json_to_tibble(result),
        "JSON" = httr2::resp_body_json(result),
        stop("Only three avilable output formats for the results: JSON, tibble or string")
      )
    } else {
      stop("\terror occurs!")
    }
  }
)




