<template>
    <v-container class="fill-height" fluid>
        <v-row justify="center" style="align-content: center;">
            <v-col cols="12" sm="8" md="4">
                <v-card class="elevation-12">           
                    <slot />                
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>
<style scoped>
    .v-card{
        padding: 20px !important;
    }
</style>