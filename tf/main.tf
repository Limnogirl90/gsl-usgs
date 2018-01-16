provider "heroku" {
  email   = "yebyen@gmail.com"
  api_key = "${var.heroku_api_key}"
}

resource "heroku_app" "gsl_usgs" {
  name   = "gsl-usgs"
  region = "us"

  buildpacks = [ ]
}

resource "heroku_app" "gsl_usgs_dev" {
  name   = "gsl-usgs-dev"
  region = "us"

  buildpacks = [ ]
}

resource "heroku_addon" "postgres_prod" {
  app = "gsl-usgs"
  plan = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "postgres_dev" {
  app = "gsl-usgs-dev"
  plan = "heroku-postgresql:hobby-dev"
}
