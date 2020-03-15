<template>
  <div>
    <h2>Accounts</h2>
    <router-link to="/accounts/new" class="btn btn-primary mb-3">New account</router-link>
    <b-table striped hover :fields="fields" :items="accounts" class="bookworm-clickable-table"
             @row-clicked="account => $router.push(`/accounts/${account.id}`)">
    </b-table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      fields: [
        {key: 'number', label: 'Number', sortable: true},
        {key: 'holder_name', label: 'Holder', sortable: true}
      ],

      accounts: []
    }
  },

  created() {
    this.$http.get('/accounts').then(resp => this.accounts = resp.data);
  }
}
</script>


