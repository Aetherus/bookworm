<template>
  <div class="d-flex flex-column vh-100 overflow-auto">
    <div>
      <b-navbar type="dark" variant="info">
        <b-navbar-brand to="/">Bookworm</b-navbar-brand>
      </b-navbar>
    </div>

    <div class="flex-grow-1 bg-dark">
      <b-row no-gutters class="align-items-stretch h-100">
        <b-col col lg="3" class="px-3 py-5" v-if="$route.meta.layout !== false">
          <b-nav vertical>
            <b-nav-item to="/books" class="bookworm-nav-item">Books</b-nav-item>
            <b-nav-item to="/accounts" class="bookworm-nav-item">Accounts</b-nav-item>
          </b-nav>
        </b-col>

        <b-col>
          <b-container fluid class="p-5 bg-light h-100 overflow-auto">
            <router-view/>
          </b-container>
        </b-col>
      </b-row>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.bookworm-nav-item {
  &, * {
    color: white !important;
  }
}
</style>

<style lang="scss">
.bookworm-clickable-table td {
  cursor: pointer !important;
}
</style>
