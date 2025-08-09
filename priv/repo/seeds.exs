alias Recheck.Services
alias Recheck.Companies
alias Recheck.Offices
alias Recheck.Accounts

if Recheck.Repo.config()[:start_apps] do
  {:ok, _} = Application.ensure_all_started(:recheck)
end

IO.puts("Seeding database...")

# Companies
company_names = ["Empresa A", "Empresa B", "Empresa C", "Empresa D", "Empresa E", "Corp"]

Enum.each(company_names, fn name ->
  case Companies.create_company(%{name: name}) do
    {:ok, company} ->
      IO.puts("✅ Created company: #{company.name}")

    {:error, %Ecto.Changeset{changes: %{name: ^name}, valid?: false}} ->
      IO.puts("ℹ️  Company '#{name}' already exists. Skipping.")

    {:error, changeset} ->
      IO.puts("❌ Error creating company '#{name}': #{inspect(changeset.errors)}")
  end
end)

# Offices
office_names = [
  "Sede",
  "Filial PA",
  "Filial MA",
  "Filial AL",
  "Filial PI",
  "Filial AP",
  "Filial RS",
  "Filial GO"
]

Enum.each(office_names, fn office_name ->
  office_attrs = %{name: office_name}

  case Offices.create_office(office_attrs) do
    {:ok, office} ->
      IO.puts("✅ Created office: #{office.name}")

    {:error, %Ecto.Changeset{changes: %{name: ^office_name}, valid?: false}} ->
      IO.puts("ℹ️  Office '#{office_name}' already exists. Skipping.")

    {:error, changeset} ->
      IO.puts("❌ Error creating office '#{office_name}': #{inspect(changeset.errors)}")
  end
end)

# Services
service_names = [
  "Serviço A",
  "Serviço B",
  "Serviço C",
  "Serviço D",
  "Serviço E",
  "Serviço F"
]

Enum.each(service_names, fn service_name ->
  service_attrs = %{name: service_name, description: "Descrição do serviço #{service_name}"}

  case Services.create_service(service_attrs) do
    {:ok, service} ->
      IO.puts("✅ Created service: #{service.name}")

    {:error, %Ecto.Changeset{changes: %{name: ^service_name}, valid?: false}} ->
      IO.puts("ℹ️  service '#{service_name}' already exists. Skipping.")

    {:error, changeset} ->
      IO.puts("❌ Error creating service '#{service_name}': #{inspect(changeset.errors)}")
  end
end)

# Users
users = [
  %{
    email: "diego@email.com",
    password: "123456789",
    role: "admin"
  },
  %{
    email: "maria@email.com",
    password: "123456789",
    role: "avaliador"
  },
  %{
    email: "joao@email.com",
    password: "123456789"
  }
]

Enum.each(users, fn user_attrs ->
  email = user_attrs.email

  case Accounts.register_user(user_attrs) do
    {:ok, user} ->
      IO.puts("✅ Created user: #{user.email}")

    {:error, %Ecto.Changeset{changes: %{email: ^email}, valid?: false}} ->
      IO.puts("ℹ️  User '#{email}' already exists. Skipping.")

    {:error, changeset} ->
      IO.puts("❌ Error creating user '#{email}': #{inspect(changeset.errors)}")
  end
end)

IO.puts("Database seeding finished.")
