<template>
  <div class="d-flex flex-column vh-100 overflow-auto">
    <div>
      <b-navbar toggleable="lg" type="dark" variant="info">
        <b-navbar-brand to="/">Bookworm</b-navbar-brand>
        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="ml-auto">
            <b-nav-item-dropdown right>
              <!-- Using 'button-content' slot -->
              <template v-slot:button-content>
                <em>{{librarian && librarian.name}}</em>
              </template>
              <b-dropdown-item @click="signOut">Sign Out</b-dropdown-item>
            </b-nav-item-dropdown>
          </b-navbar-nav>
        </b-collapse>
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

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters(['librarian'])
  },
  methods: {
    signOut() {
      this.logout().then(() => this.$router.push('/login'));
    },
    ...mapActions(['logout'])
  }
}
</script>

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
