using System.Threading.Tasks;

namespace BlazingPizza.Data;

public class PizzaService
{
    public Task<Pizza[]> GetPizzasAsync()
    {
        return Task.FromResult(new Pizza[]
        {
            new Pizza { PizzaId = 1, Name = "Margherita", Description = "Tomatoes, mozzarella, and basil", Price = 9.99M, Vegetarian = true, Vegan = false },
            new Pizza { PizzaId = 2, Name = "Pepperoni", Description = "Classic pepperoni pizza", Price = 10.99M, Vegetarian = false, Vegan = false },
            // Agrega más pizzas según sea necesario
        });
    }
}
