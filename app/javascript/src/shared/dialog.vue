<template>
        <v-row justify="center">
          <v-dialog
            v-model="dialog"
            max-width="290"
          >
            <v-card>      
            <v-card-text>
                <slot />
            </v-card-text>
      
              <v-card-actions>
                <div class="flex-grow-1"></div>
      
                <v-btn
                  color="green darken-1"
                  text
                  @click="dialog = false"
                >
                  Close
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-row>
      </template>
      
      <script>
        export default {
          data () {
            return {
              dialog: false,
            }
          },
        }
      </script>