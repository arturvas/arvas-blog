# ArVas - based on Hextra Starter Template

## Desenvolvimento Local

### Pré-requisitos

**Docker (Recomendado)**

- Docker e Docker Compose

**Instalação Local**

- Hugo (Extended version)
- Go
- Ruby
- Git

### Usando Docker

1. **Clone o repositório:**

```shell
git clone https://github.com/arturvas/arvas-blog.git
cd arvas-blog
```

2. **Inicie o ambiente:**

```shell
./scripts/dev.sh start
```

3. **Acesse o blog:**

- <http://localhost:1313>

4. **Comandos úteis:**

```shell
./scripts/dev.sh logs           # Ver logs
./scripts/dev.sh stop           # Parar ambiente
./scripts/dev.sh new-post       # Criar novo post
./scripts/dev.sh generate-index # Gerar índice
./scripts/dev.sh help           # Ver todos os comandos
```

### Instalação Local

```shell
# clone repository
git clone https://github.com/arturvas/arvas-blog.git
cd arvas-blog

# adicionar conteúdo
hugo new content/2025/08/29/hello/index.md

# gerar índice (gera _index.md + archives/_index.md)
./scripts/generate_index.rb

# build completo (produção) — sem --gc para não invalidar o cache do Netlify
hugo --minify

# dev server rápido (só renderiza 2025+ via renderSegments + in-memory + fast render)
hugo server -D

```

### Ambiente de Desenvolvimento

- Use Docker ou instale as dependências localmente
- Siga as instruções acima para configurar o ambiente

### Criando Posts

```shell
# Com Docker
./scripts/dev.sh new-post "Título do Post"

# Manualmente
hugo new content/2025/01/15/meu-post.md
```

### 5. Estrutura de um Post

```markdown
---
title: "Título do Post"
date: 2025-01-15T10:00:00-03:00
draft: false
description: "Descrição do post"
tags: [tag1, tag2]
categories: [categoria]
---

Conteúdo do post aqui...
```

## Estrutura do Projeto

```
arvas-blog/
├── content/              # Posts e páginas (Markdown)
│   └── _index.md         # Homepage (auto-gerado, posts recentes)
├── layouts/              # Templates HTML
├── assets/               # CSS, JS, imagens
├── hugo.yaml             # Configuração do Hugo (inclui render segments)
├── go.mod                # Dependências Go
├── scripts/
│   └── generate_index.rb # Gera _index.md + archives/_index.md
├── Dockerfile            # Imagem Docker
└── docker-compose.yml    # Orquestração Docker (usa --renderSegments recent)
```

