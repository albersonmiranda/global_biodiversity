library(shinytest2)

test_that("{shinytest2} recording: dataset", {
  app <- AppDriver$new(name = "dataset", height = 776, width = 1379)
  app$set_inputs(tabs = "dataset")
  app$set_inputs(`dataset-country_code` = character(0))
  app$set_inputs(`dataset-country_code_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-country_code` = "Germany")
  app$set_inputs(`dataset-country_code_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-combined_name_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-combined_name` = "10-spot Ladybird")
  app$set_inputs(`dataset-combined_name_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-dataTable_rows_current` = c(
    1, 2, 3, 4, 5, 6, 7, 8, 9,
    10
  ), allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-dataTable_rows_all` = c(
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
    30, 31, 32, 33
  ), allow_no_input_binding_ = TRUE)
  app$set_inputs(`dataset-dataTable_state` = c(
    1732296374919, 0, 10, "", TRUE, FALSE,
    TRUE, c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE,
      "", TRUE, FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE,
      FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE, FALSE,
      TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "",
      TRUE, FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE, FALSE,
      TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "",
      TRUE, FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE, FALSE,
      TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "",
      TRUE, FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE, FALSE,
      TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
    c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "",
      TRUE, FALSE, TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(
      TRUE, "", TRUE, FALSE,
      TRUE
    ), c(TRUE, "", TRUE, FALSE, TRUE), c(TRUE, "", TRUE, FALSE, TRUE),
    c(TRUE, "", TRUE, FALSE, TRUE)
  ), allow_no_input_binding_ = TRUE)
  app$expect_values()
})


test_that("{shinytest2} recording: map", {
  app <- AppDriver$new(name = "map", height = 776, width = 1379)
  app$click("home-go_to_maps")
  app$set_inputs(`maps-map_country_code` = character(0))
  app$set_inputs(`maps-map_country_code_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`maps-map_country_code` = "Poland")
  app$set_inputs(`maps-map_country_code_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`maps-map_combined_name_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`maps-map_combined_name` = "Canis lupus")
  app$set_inputs(`maps-map_combined_name_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(
    `maps-map_marker_mouseover` = c(0.689468623486239, 53.15, 22.35),
    allow_no_input_binding_ = TRUE
  )
  app$set_inputs(
    `maps-map_marker_mouseout` = c(0.876084479770005, 53.15, 22.35),
    allow_no_input_binding_ = TRUE
  )
  app$set_inputs(
    `maps-map_click` = c(53.054421865461, 22.39013671875, 0.470078964050391),
    allow_no_input_binding_ = TRUE
  )
  app$expect_values()
})


test_that("{shinytest2} recording: timeline", {
  app <- AppDriver$new(name = "timeline", height = 776, width = 1379)
  app$click("home-go_to_timeline")
  app$set_inputs(`timeline-timeline_country_code` = character(0))
  app$set_inputs(`timeline-timeline_country_code_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`timeline-timeline_country_code` = c("Albania", "Andorra", "Austria", 
      "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", 
      "Czech Republic", "Denmark", "Estonia", "Faroe Islands", "Finland", "France", 
      "Georgia", "Germany", "Gibraltar", "Greece", "Guernsey", "Hungary", "Iceland", 
      "Ireland", "Italy", "Jan Mayen", "Jersey", "Kosovo", "Latvia", "Liechtenstein", 
      "Lithuania", "Luxembourg", "Macedonia", "Malta", "Moldova", "Monaco", "Montenegro", 
      "Netherlands", "Norway", "Oceans", "Poland", "Portugal", "Romania", "San Marino", 
      "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "The Netherlands", 
      "Ukraine", "United Kingdom"))
  app$set_inputs(`timeline-timeline_country_code_open` = FALSE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`timeline-timeline_combined_name_open` = TRUE, allow_no_input_binding_ = TRUE)
  app$set_inputs(`timeline-timeline_combined_name` = "10-spot Ladybird")
  app$expect_values()
})
