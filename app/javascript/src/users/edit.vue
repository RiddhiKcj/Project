<template>
    <layout>
        <v-row justify="center">
            <v-dialog v-model="dialog" max-width="500">
                <v-card>  
                    <v-card-title>
                        <p>Whola! Account updated Successfully.</p>
                    </v-card-title>
                    <v-card-actions>
                        <div class="flex-grow-1"></div>  
                        <v-btn color="green darken-1" text @click="dialog = false">
                            <router-link to="/home">Ok</router-link>
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-row>
        <v-toolbar color="primary" dark flat>
            <v-toolbar-title>Edit</v-toolbar-title>
        </v-toolbar>
        <p id="errors" v-if="error">{{error}}</span></p>
        <v-form v-on:submit.prevent="create" accept-charset="UTF-8" class="form">
            <input type='hidden' name='_method' value='put'>
            <v-text-field v-model="userObj.username" :counter="10" label="Username" required="true"></v-text-field>
            <v-text-field v-model="userObj.email" label="E-mail" required="true" ></v-text-field>
            <v-text-field  v-model="userObj.password" type='password' label="Password" hint="At least 6 characters" counter></v-text-field>
            <v-btn class="mr-4" @click.prevent="updateUser">Update</v-btn>
            <v-btn class="mr-4" @click="navigateToRoot">Cancel</v-btn>
        </v-form>
    </layout>
</template>
<script>
import Layout from '../shared/centred_layout.vue'
export default {
    components: {
        'layout' : Layout
    },

    data: function() {
        return ({
            dialog: false,
            userObj: {
                username: this.$store.state.user.username,
                email: this.$store.state.user.email,
                password: '',
                user_id: this.$store.state.user.id
            },
            error: ''
            })
        },
    methods: {
        updateUser() {
            var self = this;
            var user_id = self.$route.params.id;
            $.ajax({
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-TOKEN', self.$store.state.csrf);
                    xhr.setRequestHeader('Authorization', 'Bearer ' + self.$store.state.access);
                    },
                url: '/api/users/'+ user_id,
                dataType: "json", 
                type: "PUT",
                data: self.userObj,
                success: function () {
                    self.dialog = true;
                },
                error: function(data){
                    if (data["responseJSON"]) {
                        self.error = data["responseJSON"]["errors"];
                    }
                }
            });
        },
        navigateToRoot() {
            this.$router.push({path: '/'});
        }
    },
    created() {
        if (!this.$store.state.signedIn) {
            this.$router.replace('/')
        } 
        else {
            this.username = this.$store.state.user.username
        }
    }
}
</script>
<style>
    #errors{
        color: rgb(230, 36, 36);
    }
</style>