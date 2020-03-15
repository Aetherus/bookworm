export default [
  {
    path: '/accounts',
    component: () => import(/* webpackChunkName: "accounts" */ './Index')
  },
  {
    path: '/accounts/new',
    component: () => import(/* webpackChunkName: "accounts" */ './New'),
  },
  {
    path: '/accounts/:id',
    component: () => import(/* webpackChunkName: "accounts" */ './Show'),
    props: route => ({id: route.params.id})
  },
]
