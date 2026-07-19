# CLAUDE.md

## Overview
Blog pessoal Hugo (pt-BR), tema Hextra via Hugo Modules. Documenta minha jornada 
estudando medicina na UNLP, La Plata, Argentina.

## Status do repositório
Este projeto começou como clone de akitaonrails.github.io. Vários arquivos legados 
dele (scripts/*.rb, docker-compose.yml) ainda estão no disco por precaução, mas 
NÃO fazem parte do meu workflow — ignore-os, não são necessários e não devem ser 
executados.

## Commands
hugo server -D          # dev local
hugo --minify            # build de produção

## Content structure
Posts em content/posts/<ano>/<mes>/<dia>/<slug>/index.md (page bundle)
Sem geração de índice manual — Hextra lista automaticamente.

## Comentários
Giscus (GitHub Discussions) — configurado mas ainda não habilitado no site.

## Deploy
Cloudflare Pages, deploy automático a cada push.