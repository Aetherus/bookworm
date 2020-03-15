<template>
  <b-jumbotron header="Sign in" class="w-50 m-auto">
    <b-form @submit.prevent="signIn">
      <b-form-group id="email-group" label="Email" label-for="email">
        <b-form-input type="email" id="email" v-model="form.email" required/>
      </b-form-group>
      <b-form-group id="password-group" label="Password" label-for="password">
        <b-form-input type="password" id="password" v-model="form.password" required/>
      </b-form-group>
      <b-button type="submit" variant="primary">Sign in</b-button>
    </b-form>
  </b-jumbotron> 
</template>

<script>
import { mapActions } from 'vuex'
export default {
  name: 'Login',

  data() {
    return {
      form: {
        email: '',
        password: ''
      }
    }
  },

  methods: {
    signIn() {
      this.login(this.form).then(() => this.$router.push('/books'))
    },
    ...mapActions(['login'])
  }
}
</script>
