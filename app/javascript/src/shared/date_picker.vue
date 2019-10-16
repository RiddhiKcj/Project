<template>
    <div class="text-center">
        <v-dialog
          v-model="date_picker_dialog"
          width="500"
                  height="600"
        >
          <template v-slot:activator="{ on }">
            <v-btn
              color="red lighten-2"
              dark
              v-on="on"
            >
              Select date
            </v-btn>
          </template>
    
          <v-card>
            <v-card-title
              class="headline grey lighten-2"
              primary-title
            >
              Select Date
            </v-card-title>
    
             <v-row justify="center">
      <v-date-picker v-model="picker"></v-date-picker>
    </v-row>
    
            <v-divider></v-divider>
    
            <v-card-actions>
              <div class="flex-grow-1"></div>
              <v-btn color="primary" text @click="date_picker_dialog = false"  > Next </v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </div>
</template>
