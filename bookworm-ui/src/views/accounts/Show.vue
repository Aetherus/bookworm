<template>
  <div>
    <section class="p-3">
      <h2>Basic information</h2>
      <div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Account number</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.number">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Holder</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.holder_name">
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label">Balance</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" :value="account.balance">
          </div>
        </div>
      </div>
    </section>

    <section class="p-3">
      <h2>Loans</h2>

      <p class="mt-3">
        <b>Total amount:</b> {{totalAmount}}
      </p>

      <b-table :fields="loanFields" :items="account.loans" class="mt-3"/>
    </section>

    <router-link to="/books">&lt; Back</router-link>
  </div>
</template>

<script>
import currency from 'currency.js'

export default {
  props: ['id'],
  data() {
    return {
      account: {
        number: null,
        holder_name: null,
        balance: null,
        loans: []
      },
      loansSearchParams: {
        from: null,
        to: null
      },
      loanFields: [
        {key: 'created_at', label: 'Created at', sortable: true},
        {key: 'book.title', label: 'Book title', sortable: true},
        {key: 'book.isbn', label: 'ISBN', sortable: true},
        {key: 'fee', label: 'Fee', sortable: true}
      ]
    }
  },

  created() {
    this.$http.get(`/accounts/${this.id}`).then(resp => this.account = resp.data)
  },

  computed: {
    totalAmount() {
      return this.account.loans.reduce((sum, loan) => sum.add(currency(loan.fee)), currency('0'));
    }
  }
}
</script>

