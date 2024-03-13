# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
# feeds live reload with acyion cable
# importmap pin "@rails/actioncable" --from jsdelivr
# pin "@rails/actioncable"
pin "@rails/actioncable", to: "@rails--actioncable.js" # @7.1.3
pin "mapbox-gl" # @3.1.2
pin "process" # @2.0.1
