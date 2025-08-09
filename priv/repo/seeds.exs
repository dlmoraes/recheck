alias Recheck.Companies
alias Recheck.Offices

if Recheck.Repo.config()[:start_apps] do
  {:ok, _} = Application.ensure_all_started(:recheck)
end

IO.puts("Seeding database...")

# Companies
company_names = ["Empresa A", "Empresa B", "Empresa C"]

Enum.each(company_names, fn name ->
  # Para cada nome, tentamos criar a empresa usando a função do contexto
  case Companies.create_company(%{name: name}) do
    # Se a criação for bem-sucedida, exibimos uma mensagem de sucesso
    {:ok, company} ->
      IO.puts("✅ Created company: #{company.name}")

      office_names_pool = [
        "Sede",
        "Filial Pará",
        "Filial Maranhão",
        "Filial Alagoas",
        "Filial Piaui",
        "Filial Amapa",
        "Filial Rio Grande do Sul",
        "Filial Goias"
      ]

      number_of_offices = Enum.random(1..2)

      offices_to_create = Enum.take_random(office_names_pool, number_of_offices)

      Enum.each(offices_to_create, fn office_name ->
        office_attrs = %{name: office_name, company_id: company.id}

        case Offices.create_office(office_attrs) do
          {:ok, office} ->
            IO.puts("✅ Created office: #{office.name}")

          {:error, %Ecto.Changeset{changes: %{name: ^office_name}, valid?: false}} ->
            IO.puts("ℹ️  Office '#{office_name}' already exists. Skipping.")

          {:error, changeset} ->
            IO.puts("❌ Error creating office '#{office_name}': #{inspect(changeset.errors)}")
        end
      end)

    {:error, %Ecto.Changeset{changes: %{name: ^name}, valid?: false}} ->
      IO.puts("ℹ️  Company '#{name}' already exists. Skipping.")

    {:error, changeset} ->
      IO.puts("❌ Error creating company '#{name}': #{inspect(changeset.errors)}")
  end
end)

IO.puts("Database seeding finished.")
