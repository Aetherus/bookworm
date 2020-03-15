import Vue from 'vue'
import VueRouter from 'vue-router'
import booksRoutes from '@/views/books/routes'
import accountsRoutes from '@/views/accounts/routes'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/books'
  },
  {
    path: '/login',
    name: 'Login',
    meta: {
      layout: false,
      authentication: false
    },
    component: () => import(/* webpackChunkName: "login" */ '../views/Login.vue')
  },
  ...booksRoutes,
  ...accountsRoutes
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to, from, next) => {
  if (to.meta.authentication === false || window.localStorage.getItem('accessToken')) {
    next();
  } else {
    next('/login');
  }
})

export default router
