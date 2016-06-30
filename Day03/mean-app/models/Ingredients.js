var mongoose = require('mongoose');

var IngredientSchema = new mongoose.Schema({
  name: String,
  description: String
});

mongoose.model('Ingredient', IngredientSchema);