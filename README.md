# 💸 Ta Caro App - Flutter Race #1

Um aplicativo desenvolvido em [Flutter](https://flutter.dev) no evento [Flutter Race #1](https://cadastro.flutterrace.com/primeira), com intuito de ajudar as pessoas a terem um melhor controle dos preços dos produtos.

## Packages utilizados 

- [Font Awesome](https://pub.dev/packages/font_awesome_flutter)
- [Google Fonts](https://pub.dev/packages/google_fonts)  
- [SupaBase](https://pub.dev/packages/supabase)
- [Validators](https://pub.dev/packages/validators)


## Layout 

[Figma do projeto](https://www.figma.com/file/M60t8ulOCV7TCEYuLyrlA3/T%C3%A1-caro%3F?node-id=0%3A1)

## Configurando o projeto

Crie um projeto no Supabase e defina no arquivo launch.json as configurações do seu App (remova .example do arquivo launch.example.json).

```cl
"args": [
    "--dart-define",
    "SUPABASEURL=",
    "--dart-define",
    "SUPABASEKEY="
]
```

Ainda no Supabase crie as seguintes tabelas:

users

| Coluna        | Tipo        |
| ------------- |------------ |
| `id`          | uuid        |
| `created_at`  | timestamptz |
| `name`        | text        |
| `email`       | text        |

orders

| Coluna      | Tipo        |
| ------------|------------ |
| `id`        | uuid        |
| `created_at`| timestamptz |
| `created`   | date        |
| `name`      | text        |
| `price`     | float4      |
| `user`      | uuid        |


<p>Na tabela orders, a coluna user tem a relação user -> users.id como chave estrangeira</p>
