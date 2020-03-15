import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import axiosInstance from './config/axios'
import { BootstrapVue, BootstrapVueIcons } from 'bootstrap-vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(BootstrapVueIcons)

Vue.config.productionTip = false

Vue.prototype.$http = axiosInstance;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
