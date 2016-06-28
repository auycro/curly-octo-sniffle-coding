var mongoose = require('mongoose');

var RecipeSchema = new mongoose.Schema({
  name: String,
  description: String,
  upvote: {type: Number, default: 0},
  ingredients: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Ingredient' }]
});

mongoose.model('Recipe', RecipeSchema);