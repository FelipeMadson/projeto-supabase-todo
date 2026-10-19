# Aplicativo de Tarefas Serverless com Supabase

Aplicação web responsiva de página única para gestão de tarefas, construída com JavaScript moderno e integrada diretamente ao Supabase (PostgreSQL com Row Level Security).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

*Read this in [English](README.md).*

---

## Destaques da Arquitetura

- **Frontend Moderno Vanilla**: Dispensa bundlers complexos; executa diretamente em navegadores modernos.
- **Persistência em PostgreSQL**: Integração com a infraestrutura Supabase via SDK cliente.
- **Tema Adaptativo**: Suporte nativo a tema claro e escuro (`prefers-color-scheme: dark`) com contraste balanceado.
- **Segurança Declarativa**: Esquema SQL (`schema.sql`) com suporte a Row Level Security (RLS).

---

## Configuração do Banco de Dados

Execute o arquivo `schema.sql` no Editor SQL do seu painel Supabase:

```sql
create table if not exists todos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  is_complete boolean default false,
  inserted_at timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table todos enable row level security;
```

---

## Execução Local

1. Abra o arquivo `index.html` diretamente no navegador ou sirva via servidor estático:
   ```bash
   npx serve .
   ```
2. Insira as credenciais (Project URL e Anon Key) do seu projeto Supabase no `index.html`.

## Licença

MIT © [Felipe Madson](https://github.com/FelipeMadson)
