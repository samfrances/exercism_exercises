defmodule BoutiqueSuggestions do
  @default_options [maximum_price: 100]

  def get_combinations(tops, bottoms, options \\ []) do
    options = Keyword.merge(@default_options, options)
    for top = %{base_color: top_base, price: top_price} <- tops,
        bottom = %{base_color: bottom_base, price: bottom_price} <- bottoms,
        top_base != bottom_base,
        top_price + bottom_price <= options[:maximum_price] do
      {top, bottom}
    end
  end
end
