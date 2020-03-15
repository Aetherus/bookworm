export default [
  {
    path: '/books',
    component: () => import(/* webpackChunkName: "books" */ './Index')
  },
  {
    path: '/books/new',
    component: () => import(/* webpackChunkName: "books" */ './New'),
  },
  {
    path: '/books/:id',
    component: () => import(/* webpackChunkName: "books" */ './Show'),
    props: route => ({id: route.params.id})
  },
]
