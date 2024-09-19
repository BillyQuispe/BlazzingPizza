using System.Threading.Tasks;

namespace BlazingPizza.Data;

public class PizzaService
{
    public Task<Pizza[]> GetPizzasAsync()
    {
        // Aquí puedes simular datos o llamar a una base de datos
        var pizzas = new[]
        {
            new Pizza { PizzaId = 1, Name = "Margherita", Description = "Classic cheese and tomato pizza", Price = 9.99M, Vegetarian = true, Vegan = false },
            new Pizza { PizzaId = 2, Name = "Pepperoni", Description = "Spicy pepperoni slices", Price = 10.99M, Vegetarian = false, Vegan = false },
            new Pizza { PizzaId = 3, Name = "Veggie", Description = "Loaded with fresh vegetables", Price = 11.99M, Vegetarian = true, Vegan = true },
        };
        return Task.FromResult(pizzas);
    }
}
