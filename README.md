# ArVas — blog pessoal (baseado no Hextra Starter Template)

Diário de um brasileiro estudando medicina na UNLP, La Plata, Argentina.

## Stack

- [Hugo](https://gohugo.io) (Extended) + tema [Hextra](https://github.com/imfing/hextra) via Hugo Modules
- Ruby (só localmente, pra gerar o índice da home)
- Deploy automático via [Cloudflare Pages](https://pages.cloudflare.com) a cada push na `main`
- Comentários via [Giscus](https://giscus.app) (GitHub Discussions)

## Pré-requisitos

- Hugo Extended — `brew install hugo`
- Go — `brew install go` (necessário pro Hugo Modules resolver o tema)
- Ruby — `brew install ruby` (só pro script de índice)
- Git

Docker é **opcional** `docker-compose.yml`/`dev.sh` existem no repo por precaução, mas o fluxo abaixo não depende deles.

## Fluxo de trabalho: publicar um post novo

**1. Criar o post** (pasta com data + slug, page bundle):

```shell
hugo new content/posts/2026/07/19/titulo-do-post/index.md
```

Isso gera o arquivo com front matter pronto (`draft: true` por padrão) e cria a pasta certa pra você poder colocar imagens junto depois, se quiser (`content/posts/2026/07/19/titulo-do-post/foto.jpg`).

**2. Escrever o conteúdo** no `index.md` gerado.

**3. Tirar do rascunho**, quando terminar:

```yaml
draft: false
```

**4. Regenerar o índice da home** — passo fácil de esquecer, mas essencial:

```shell
ruby scripts/generate_index.rb
```

Sem isso, o post existe (a URL individual funciona), mas **não aparece listado** na home — ela é um arquivo gerado, não dinâmico.

**5. Conferir localmente:**

```shell
hugo server -D
```

Abre `http://localhost:1313`, confirma que o post aparece na home e que o conteúdo está como esperado.

**6. Commit e push:**

```shell
git add .
git commit -m "Novo post: título aqui"
git push origin main
```

O Cloudflare Pages builda e publica automaticamente.

## Comentários (Giscus)

Configurados em `hugo.yaml` sob `params.comments`. Usa GitHub Discussions do próprio repositório. Se precisar reconfigurar (trocar categoria, etc.), gera um novo bloco em [giscus.app](https://giscus.app/pt), selecionando a categoria pela lista suspensa, e copia `repoId`/`categoryId` pro `hugo.yaml`.

## Estrutura do projeto

```
arvas-blog/
├── content/
│   ├── _index.md          # Homepage — AUTO-GERADO por generate_index.rb
│   ├── about.md            # Página "Sobre"
│   └── posts/
│       └── 2026/07/19/titulo-do-post/
│           └── index.md
├── layouts/
│   └── partials/custom/
│       └── head-end.html   # CSS customizado (tipografia, cores, easter eggs)
├── assets/
│   └── js/                 # FlexSearch (busca nativa, embutida no tema)
├── scripts/
│   └── generate_index.rb   # Gera content/_index.md a partir dos posts
├── hugo.yaml                # Config principal (tema, comentários, busca, menu)
└── go.mod                   # Dependência do Hugo Modules (tema Hextra)
```

## Comandos úteis

```shell
hugo server -D        # dev local, inclui rascunhos
hugo --minify          # build de produção (o que o Cloudflare Pages roda)
ruby scripts/generate_index.rb   # regenera a home após mudar/criar/remover posts
```
