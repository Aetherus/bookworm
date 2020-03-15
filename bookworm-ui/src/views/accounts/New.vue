<template>
  <div>
    <h2>New Account</h2>
    <b-form @submit.prevent="createBook">
      <b-form-group label="Holder" description="Holder is required">
        <b-form-input
          v-model="account.holder_name"
          required
          placeholder="John Doe"
        />
      </b-form-group>
      <b-form-group label="Balance" description="Balance is required">
        <b-form-input
          type="number"
          min="0"
          step="0.10"
          v-model="account.initial_balance"
          required
          placeholder="100.00"
        />
      </b-form-group>

      <b-button type="submit" variant="primary">Create</b-button>
      
      <b-form-group label="Account Number">
        <h3>{{account.number}}</h3>
      </b-form-group>
    </b-form>
    <router-link to="/accounts">&lt; Back</router-link>
  </div>
</template>

<script>
export default {
  data() {
    return {
      account: {
        holder_name: null,
        initial_balance: null,
        number: null
      }
    }
  },

  methods: {
    createBook() {
      this.$http.post('/books', this.book).then(resp => this.account.number = resp.data.number);
    }
  }
}
</script>
