// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

/* eslint no-console:0 */

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'

// Import all the macro components of the application
import * as instances from '../instances'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
    // Initialize available instances
    Object.keys(instances).forEach((instanceName) => {
        const instance = instances[instanceName]
        const elements = document.querySelectorAll(instance.el)

        elements.forEach((element) => {
            const props = JSON.parse(element.getAttribute('data-props'))

            new Vue({
                el: element,
                render: h => h(instance.component, { props })
            })
        })
    })
})

