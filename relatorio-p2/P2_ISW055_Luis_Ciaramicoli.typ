// ============================================================
//  P2 — Relatório consolidado: arquitetura e atividades (INDIVIDUAL)
//  ISW055 · Introdução à Computação em Nuvem · Fatec Pompeia · 2026.2
//
//  Entrega: 13/11/2026 · PDF nomeado P2_ISW055_Nome_Sobrenome.pdf,
//  em docs/ do repositório do produto, com link no README e uma issue
//  "Entrega — P2" mencionando @siriani
// ============================================================

// ---------- DADOS DO ALUNO (edite aqui) ----------
#let aluno = "Luis Gustavo Bonfim Ciaramicoli"
#let turma = "161_SIST. INTELIGENTES_N"
#let produto = "PostCraft AI"
#let repositorio = "https://github.com/luisciaramicoli/postcraft-ai"
#let data-relatorio = "12/11/2026"

// ---------- daqui pra baixo, só mexa nas seções e nas fichas ----------
#let disciplina = "Introdução à Computação em Nuvem"
#let codigo = "ISW055"
#let professor = "Prof. Allan Lincoln Rodrigues Siriani"
#let accent = rgb("#b96f1f")

#set document(title: "P2 — " + codigo + " — " + aluno, author: aluno)
#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2cm))
#set text(size: 11pt, lang: "pt", region: "BR")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")
#show heading.where(level: 1): it => { v(0.6em); text(size: 16pt, it); v(0.2em) }
#show heading.where(level: 2): it => { v(0.5em); text(size: 13pt, it); v(0.1em) }
#show link: set text(fill: accent)
#show figure.caption: set text(size: 9pt, fill: luma(90))
#set table(stroke: 0.5pt + luma(200), inset: 6pt)
#show table: set text(hyphenate: false)
#show table: set par(justify: false)

// ---------- ajudantes ----------
#let orientacao(body) = block(
  width: 100%, fill: luma(245), inset: 9pt, radius: 4pt,
  stroke: (left: 2pt + luma(180)),
  text(size: 9.5pt, fill: luma(90), body),
)

#let evidencia(legenda, arquivo: none) = figure(
  if arquivo == none {
    rect(width: 100%, height: 5.5cm, radius: 4pt, stroke: (paint: luma(170), dash: "dashed"))[
      #align(center + horizon)[
        #text(fill: luma(130), size: 9.5pt)[
          cole o print ou o diagrama aqui \
          troque `arquivo: none` por `arquivo: "prints/nome.png"`
        ]
      ]
    ]
  } else {
    image(arquivo, width: 100%)
  },
  kind: image,
  supplement: [Figura],
  caption: legenda,
)

#let registro = state("registro", ())

#let registrar(numero, titulo, planejada, realizada, situacao) = registro.update(l => l + ((
  numero: numero, titulo: titulo,
  planejada: planejada, realizada: realizada, situacao: situacao,
),))

#let atividade(
  numero, titulo,
  descricao: "",
  planejada: "",
  realizada: "—",
  situacao: "entregue",   // entregue · entregue com atraso · não entregue
  evidencia: "",
  url: "",
  corpo,
) = {
  registrar(numero, titulo, planejada, realizada, situacao)
  heading(level: 2, [Atividade #numero — #titulo])
  table(
    columns: (3.4cm, 1fr),
    fill: (x, y) => if x == 0 { luma(245) } else { none },
    [*Descrição*], [#descricao],
    [*Data planejada*], [#planejada],
    [*Data realizada*], [#realizada],
    [*Situação*], [#situacao],
    [*Evidência*], [#evidencia],
    [*Link*], [#if url == "" [—] else [#link(url)]],
  )
  corpo
}

// ============================================================
//  CAPA
// ============================================================
#align(center)[
  #v(2.5cm)
  #text(size: 12pt, tracking: 0.12em)[FATEC POMPEIA]
  #v(0.4em)
  #text(size: 10.5pt, fill: luma(110))[#disciplina · #codigo · #turma]
  #v(4cm)
  #text(size: 26pt, weight: "bold")[P2]
  #v(0.3em)
  #text(size: 18pt, weight: "bold")[Relatório consolidado]
  #v(0.2em)
  #text(size: 13pt)[arquitetura e atividades do 2º bimestre]
  #v(0.8em)
  #text(size: 11pt, fill: luma(110))[Avaliação individual · 2026.2]
  #v(3.2cm)
  #text(size: 14pt)[#aluno]
  #v(0.5em)
  #text(size: 11pt)[Produto: *#produto*] \
  #text(size: 9.5pt)[#link(repositorio)]
  #v(1fr)
  #text(size: 10.5pt)[#professor \ Pompeia, #data-relatorio]
]

#set page(
  numbering: "1",
  number-align: right,
  header: context {
    set text(size: 8pt, fill: luma(120))
    [#codigo · P2 — Relatório consolidado #h(1fr) #aluno]
    line(length: 100%, stroke: 0.4pt + luma(200))
  },
)
#counter(page).update(1)

#outline(title: "Sumário", indent: 1.2em, depth: 2)
#pagebreak()

// helper extra (mesma aparência de `evidencia`, com largura ajustável para prints altos)
#let evid(legenda, arquivo, largura: 100%) = figure(
  image(arquivo, width: largura), kind: image, supplement: [Figura], caption: legenda,
)

// ============================================================
= Introdução
// ============================================================
Introdução à Computação em Nuvem (ISW055), na Fatec Pompeia, propõe que o aluno aprenda nuvem construindo e operando um sistema de verdade: containers com Docker, serviços separados que conversam por uma rede interna, autenticação e autorização no servidor, logs de auditoria, armazenamento de objetos, cobrança com Stripe e publicação em um domínio. Em vez de exercícios isolados, cada atividade acrescenta uma peça ao mesmo projeto, e este relatório consolida o segundo bimestre.

O projeto começou como o CineCloud, um catálogo de filmes com cadastro, login, favoritos e comentários. Nas atividades 7 e 8 ele ganhou um plano pago com Stripe e uma documentação reversa. Na atividade 9 o repositório foi copiado com o histórico para um repositório novo, o do PostCraft AI, e nas atividades 10 e 11 o domínio de filmes foi trocado por um negócio próprio: um gerador de carrosséis e legendas para Instagram, voltado a profissionais autônomos (nutricionistas, advogados, personal trainers, psicólogos) que precisam publicar com regularidade, mas não têm tempo para planejar roteiros, escrever legendas e manter uma identidade visual.

O produto oferece um plano gratuito, limitado a três posts gerados por mês, e uma assinatura chamada Creator Pro, de R\$ 49,90 por mês, sem limite de gerações. Para essa promessa ser verdadeira, o servidor precisa saber quem é o usuário, qual é o seu papel, a quem pertence cada registro e se a assinatura está ativa. Este relatório mostra a arquitetura que existe hoje no repositório e na stack, as cinco entregas das atividades 7 a 11 com as respectivas evidências e, com a mesma clareza, aquilo que ainda não está pronto.

O documento está organizado como pede o enunciado: metodologia, arquitetura do SaaS em oito partes, quadro de entregas gerado a partir das fichas, uma ficha por atividade, considerações finais e declaração de autoria.

// ============================================================
= Metodologia
// ============================================================
As atividades 7 e 8 foram feitas no repositório do catálogo de filmes, o mesmo do primeiro bimestre. Na atividade 9, o histórico desse repositório foi preservado no repositório novo `luisciaramicoli/postcraft-ai`, onde o SaaS foi desenvolvido nas atividades 10 e 11. Por isso os commits das atividades 7 e 8 aparecem com o mesmo hash nos dois repositórios. O desenvolvimento usou Docker Compose localmente e a stack do Portainer para publicação, e o código das imagens é construído pelo GitHub Actions e publicado no GHCR.

Cada data e hora de entrega vem do histórico Git (`git log`) e foi conferida na página do commit no GitHub. Da atividade 9 em diante, usei também a data de abertura da issue de entrega que menciona o professor, convertida de UTC para o horário de Brasília (UTC−03:00). Os prints mostram páginas reais do GitHub, o sistema em execução e, nas fichas, um registro textual com o hash e o horário absolutos, porque o GitHub mostra datas relativas. As capturas feitas por mim em 12/11/2026 trazem uma faixa com data e hora de captura.

Há duas ressalvas de método. Primeiro, a URL pública do produto foi consultada em 12/11/2026, às 21:56, e o nome da stack no Portainer e a identificação da VM não puderam ser confirmados a partir dos arquivos; por isso não são afirmados aqui. Segundo, os testes de 403 e de eventos no log (atividade 10) e o ciclo de assinatura (atividade 11) foram feitos numa instância local, construída com o código mais recente, em contas de teste e com o Stripe em modo de teste; o webhook, porém, foi entregue pelo próprio Stripe. Data de código ou de issue não prova aprovação do professor nem o funcionamento de tudo o que a interface anuncia.

A redação e a montagem deste documento tiveram assistência de IA, que também executou parte dos testes descritos. Nenhum registro de pagamento, publicação ou entrega foi inventado: o que não foi comprovado está marcado como pendência.

// ============================================================
= Arquitetura do SaaS
// ============================================================
== Visão geral e componentes

O diagrama mostra o sistema como ele está no repositório e no Compose. O navegador chega ao app pelo domínio público; os demais serviços do Compose só se enxergam pela rede interna do Docker, por nome de serviço. O Stripe é o único serviço externo que chama o app, por meio do webhook.

#evid([Diagrama de componentes e microsserviços do PostCraft AI], "diagramas/d1.png")

#table(
  columns: (3cm, 1fr, 3.4cm, 2.6cm),
  fill: (x, y) => if y == 0 { luma(235) } else { none },
  table.header([*Componente*], [*Responsabilidade*], [*Tecnologia / imagem*], [*Público?*]),
  [app], [telas (React), API do negócio (posts, marcas, perfil), landing page, checkout e webhook, geração de conteúdo via Gemini], [Node 20, Express, Vite; `postcraft-app`], [sim (domínio, porta 8218)],
  [auth-service], [cadastro, login, sessão e papéis (RBAC)], [Node, Express; `postcraft-auth`], [não (rede interna)],
  [log-service], [eventos de negócio e auditoria (CloudEvents)], [Node, Express; `postcraft-log-service`], [não (rede interna)],
  [Redis], [armazenamento dos logs (Redis Streams, 256 MB)], [`redis:7-alpine`], [não (rede interna)],
  [MariaDB], [usuários, marcas, posts, templates e dados de assinatura], [MariaDB fora do Compose, acessado por `DB_HOST`], [não (só a stack acessa)],
  [MinIO], [fotos de perfil, logos e imagens de posts], [MinIO (imagem do projeto no GHCR)], [porta não publicada; bucket de leitura pública],
  [Stripe (externo)], [checkout, assinaturas, webhooks], [serviço SaaS], [webhook → app],
  [Gemini (externo)], [texto e imagem dos posts], [API do Google], [app → Gemini],
  [Prometheus e Grafana], [métricas e painéis], [`prom/prometheus`, `grafana/grafana`], [Prometheus só em 127.0.0.1],
)

== Onde roda

O produto é servido em #link("https://luis-ciaramicoli-isw055.lapps.studio/"), o mesmo domínio usado desde o início do semestre, com o app exposto na porta 8218 do host. O código vem do repositório `luisciaramicoli/postcraft-ai`: o Compose de produção (`docker-compose.prod.yml`) referencia as imagens `postcraft-app`, `postcraft-auth` e `postcraft-log-service` no GHCR, construídas pelo GitHub Actions, além de `redis:7-alpine`, MinIO, Prometheus, Grafana e Watchtower. Os containers são o app, o auth-service, o log-service, o Redis, o MinIO, o Prometheus, o Grafana e o Watchtower.

Os arquivos Compose não definem limite de memória por container; o único limite é o `maxmemory` de 256 MB do Redis, que vale apenas para os dados dele. A afirmação de 1 GB feita na issue 8 não aparece nos arquivos e não é tratada como configuração comprovada. O nome da stack no Portainer e a identificação da VM também não constam nos arquivos do repositório e não foram verificados por mim.

Variáveis de ambiente (somente os nomes): `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `JWT_SECRET`, `AUTH_SERVICE_URL`, `LOG_SERVICE_URL`, `MINIO_ENDPOINT`, `MINIO_ACCESS_KEY`, `MINIO_SECRET_KEY`, `MINIO_BUCKET`, `STRIPE_SECRET_KEY`, `STRIPE_PRICE_ID`, `STRIPE_WEBHOOK_SECRET`, `GEMINI_API_KEY`, `GEMINI_TEXT_MODEL`, `GEMINI_IMAGE_MODEL`, `SMTP_USER`, `SMTP_PASS`, `PUBLIC_URL`, `COOKIE_SECURE` e `CORS_ORIGINS`. O Compose de produção traz valores padrão inseguros para alguns segredos, que precisam ser substituídos na stack; os valores não são reproduzidos aqui.

== Fluxo de uma requisição

Ação escolhida: o criador gera um post com IA. (1) O navegador envia `POST /api/posts/generate` ao domínio, que entrega ao app; o cookie HttpOnly com o JWT acompanha a requisição. (2) O middleware valida o token e consulta o auth-service para confirmar o papel: `criador` e `admin` podem criar, `revisor` recebe 403. (3) O controlador conta no MariaDB os posts gerados pelo usuário no mês corrente; se o usuário não é premium e já tem três, responde 403 com o código `limite_gratuito_atingido`, antes de chamar o Gemini. (4) Caso contrário, o serviço de geração chama o Gemini (texto e imagem) e o controlador grava o post com `usuario_id` da sessão. (5) O log-service recebe o evento de negócio e o grava no Redis Streams. (6) A API responde 201 com o post. Nas listagens, usuários comuns recebem apenas registros filtrados por `usuario_id`; o administrador tem um caminho específico para consulta ampliada.

== Fluxo de assinatura

O fluxo parte do botão "Fazer Upgrade para Creator Pro" no perfil. O app cria uma Checkout Session em `mode=subscription` com o preço configurado, o `client_reference_id` do usuário e a metadata `userId`; o usuário paga na página hospedada do Stripe, e o app nunca recebe dados de cartão. A confirmação depende do webhook, não do retorno do navegador: o app valida a assinatura do evento com `constructEvent`, usando o corpo bruto e `STRIPE_WEBHOOK_SECRET`, e rejeita com 400 quando o cabeçalho falta ou a assinatura não confere. O evento `checkout.session.completed` grava `premium=1`, `stripe_customer_id` e `stripe_subscription_id` e registra um evento de auditoria; `customer.subscription.deleted` zera `premium` pelo `stripe_subscription_id`. A cota é aplicada na API de geração, que ignora o limite para usuários premium.

#evid([Fluxo de assinatura: checkout, webhook, plano no banco e limite], "diagramas/d2.png")

Três lacunas estão declaradas. Não existe rota do portal do cliente, então o cancelamento foi testado pela API do Stripe e não pelo portal. Não há armazenamento dos IDs de evento: se o mesmo evento chegar duas vezes, o `UPDATE` mantém o mesmo valor, mas isso não é idempotência completa, pois efeitos secundários, como o evento de auditoria, se repetem. E os eventos `customer.subscription.updated` e `invoice.payment_failed` não são tratados. A validação ponta a ponta do ciclo está na ficha da atividade 11.

== Modelo de dados do domínio

#evid([Modelo de dados do domínio], "diagramas/d3.png")

O vínculo entre usuário, plano e assinatura está em `usuarios`: `premium`, `stripe_customer_id` e `stripe_subscription_id`. Não existe uma tabela de planos ou de limites; a cota gratuita é calculada por contagem em `posts`. O script `db/001_dominio.sql` usa explicitamente o nome de banco `cloud_atividade`, que deve ser alinhado ao `DB_NAME` da implantação.

== Segurança

Há três papéis, atribuídos e verificados pelo auth-service: `criador` (padrão no cadastro), `revisor` e `admin`. A autorização é aplicada no backend, nas rotas, e não na interface.

#table(
  columns: (1fr, 2.4cm, 2.4cm, 2.4cm),
  align: (left, center, center, center),
  fill: (x, y) => if y == 0 { luma(235) } else { none },
  table.header([*Ação*], [*admin*], [*criador*], [*revisor*]),
  [criar, gerar, editar e excluir os próprios posts e marcas], [sim], [sim], [não (403)],
  [ver os próprios posts], [sim], [sim], [sim],
  [ver, editar ou excluir posts de outro usuário], [sim], [não (403)], [não (403)],
  [listar usuários e consultar o log de auditoria], [sim], [não (403)], [não (403)],
  [assinar o plano Creator Pro], [sim], [sim], [sim],
)

O isolamento por usuário é garantido nas consultas: a listagem usa `WHERE usuario_id = ?` com o identificador da sessão, e a leitura, a edição e a exclusão de um post comparam o dono com o usuário autenticado e respondem 403 quando diferem, com exceção do administrador. As consultas são parametrizadas. Cada negação gera um evento `tentativa_negada_403` no log-service. Os segredos ficam em variáveis de ambiente da stack; o repositório traz um `.env.example` apenas com os nomes. Pendências: o Compose de produção ainda contém valores padrão para segredos, que devem ser trocados, o HTTPS com cookie seguro precisa ser configurado (`COOKIE_SECURE`) e o isolamento deve continuar sendo testado com mais de uma conta.

== Observabilidade, CI/CD e documentação da API

Foram feitas as extras: health checks nos containers, métricas Prometheus com painel no Grafana, documentação OpenAPI/Swagger e um pipeline do GitHub Actions que instala dependências, executa os testes dos três serviços, valida o build e publica as imagens no GHCR; o Watchtower está previsto para atualizar as imagens. Não foi confirmada uma execução recente da implantação pública a partir desse pipeline.

== Camadas IaaS, PaaS e SaaS do projeto

#table(
  columns: (2cm, 1fr, 3.6cm),
  fill: (x, y) => if y == 0 { luma(235) } else { none },
  table.header([*Camada*], [*O que é no seu projeto*], [*Quem gerencia*]),
  [IaaS], [a VM, a rede e o disco onde a stack roda e o servidor do MariaDB externo], [Fatec / professor (infraestrutura da disciplina)],
  [PaaS], [Docker e Portainer como plataforma de execução; GitHub Actions e GHCR para build e entrega; Redis e MinIO operados como containers], [eu, sobre a plataforma fornecida; não é PaaS gerenciado contratado],
  [SaaS], [o PostCraft AI, para o cliente final; e os SaaS que uso: Stripe (cobrança), Gemini (IA) e GitHub], [eu (produto); Stripe, Google e GitHub (fornecedores)],
)

// ============================================================
= Quadro de entregas
// ============================================================
#context {
  let l = registro.final().sorted(key: a => a.numero)
  table(
    columns: (auto, 1fr, 2.3cm, 3.6cm, 2.4cm),
    align: (center, left, center, center, center),
    fill: (x, y) => if y == 0 { luma(235) } else { none },
    table.header([*Nº*], [*Atividade*], [*Data \ planejada*], [*Data \ realizada*], [*Situação*]),
    ..l.map(a => ([#a.numero], [#a.titulo], [#a.planejada], [#a.realizada], [#a.situacao])).flatten(),
  )
}

// ============================================================
= Atividades realizadas
// ============================================================
#atividade(
  7, "Plano Premium — cobrança de verdade com Stripe",
  descricao: "Plano pago em modo de teste: Checkout Session do Stripe e webhook marcando o usuário como premium.",
  planejada: "09/10/2026",
  realizada: "15/10/2026 14:19",
  situacao: "entregue com atraso",
  evidencia: "GitHub — commit + print do checkout concluído e do usuário premium",
  url: "https://github.com/luisciaramicoli/postcraft-ai/commit/35adf09e2c253a4f059faf2b5a07fbc6d1aa743e",
)[
  *O que foi feito.* No catálogo CineCloud, o botão de upgrade passou a criar uma Checkout Session do Stripe em modo de teste, e um webhook com assinatura verificada marca o usuário como premium. O benefício comprovável era a remoção do limite de favoritos e o selo Premium no perfil. Nenhum dado de cartão passa pelo servidor.

  Registro do commit `35adf09e2c25`: data 15/10/2026 14:19:35 (UTC−03:00), assunto "feat(stripe): implementa plano premium com checkout, webhooks e beneficios reais (atividade 7)".

  #evid([Atividade 7 — evidência da entrega (commit no GitHub; datas absolutas na figura de comprovação abaixo)], "prints/atividade-7.png", largura: 85%)
  #evid([Comprovação de datas: `git log` dos commits das atividades 7 a 10 (horário local) e `created_at` das issues 7 e 8], "prints/comprovante-datas.png")
  #evid([Atividade 7 — resultado: checkout do Stripe em modo de teste (evidência histórica de 15/10/2026)], "../docs/print-stripe-checkout.png", largura: 80%)
  #evid([Atividade 7 — resultado: benefício premium no CineCloud (evidência histórica de 15/10/2026)], "../docs/print-beneficio-premium.png", largura: 80%)

  *Dificuldades e como foram resolvidas.* A entrega ocorreu depois do prazo de 09/10, e por isso conta como entregue com atraso. As imagens do resultado são do CineCloud original e comprovam o contexto da atividade, não uma assinatura do PostCraft; a assinatura do PostCraft foi testada na atividade 11.
]

#atividade(
  8, "SaaS, PaaS, IaaS — e a documentação que o projeto nunca teve",
  descricao: "Camadas de nuvem do próprio projeto e documentação reversa: especificação, arquitetura, regras de negócio e modelo de dados.",
  planejada: "16/10/2026",
  realizada: "15/10/2026 14:32",
  situacao: "entregue",
  evidencia: "GitHub — commit + DOCUMENTACAO.md linkado no README",
  url: "https://github.com/luisciaramicoli/postcraft-ai/commit/62c3edaa8c0213da71c467e1648fe13843350387",
)[
  *O que foi feito.* Escrevi a documentação reversa do sistema em `DOCUMENTACAO.md`, com especificação funcional, arquitetura distribuída, regras de negócio no formato "se X, então Y", modelo de dados e a classificação da pilha em SaaS, PaaS e IaaS, e liguei o arquivo ao README. O documento descreve o CineCloud; as diferenças do domínio PostCraft estão na seção de arquitetura deste relatório.

  Registro do commit `62c3edaa8c02`: data 15/10/2026 14:32:13 (UTC−03:00), assunto "docs: encerramento do projeto com classificacao saas/paas/iaas e documentacao reversa (atividade 8)".

  #evid([Atividade 8 — evidência da entrega (commit no GitHub)], "prints/atividade-8.png", largura: 85%)
  #evid([Atividade 8 — resultado: README do commit com os links para `DOCUMENTACAO.md`], "prints/atividade-8-readme.png")
  #evid([Atividade 8 — resultado: diagrama de arquitetura publicado na documentação], "../docs/diagrama-arquitetura-cinecloud.png", largura: 90%)

  *Dificuldades e como foram resolvidas.* O principal cuidado foi não descrever como existente o que ainda não existia; o documento original retrata o CineCloud, e a diferença para o produto atual foi tratada na seção 3 deste relatório.
]

#atividade(
  9, "Fork e plano de negócio",
  descricao: "Repositório novo com o histórico do anterior, README do produto (dor, persona, Lean Canvas, modelo de receita, mapa de reaproveitamento) e backlog em issues.",
  planejada: "23/10/2026",
  realizada: "06/11/2026 20:57",
  situacao: "entregue com atraso",
  evidencia: "GitHub — issue de entrega (@siriani) + repositório novo + README do produto + print do histórico de commits e das issues",
  url: "https://github.com/luisciaramicoli/postcraft-ai/issues/7",
)[
  *O que foi feito.* Criei o repositório `postcraft-ai` com todo o histórico do catálogo (33 commits anteriores ao da atividade, incluindo os das atividades 7 e 8) e escrevi o plano do negócio: proposta de valor, persona, modelo de receita (gratuito com limite e Creator Pro), Lean Canvas e mapa de reaproveitamento dos serviços do CineCloud. O backlog ficou em issues. A issue de entrega, que menciona o professor, foi aberta em 06/11/2026 às 20:57 (23:57 UTC), e o commit do plano é `98a09461ee1a`, de 06/11/2026 20:56:48.

  #evid([Atividade 9 — evidência da entrega (issue de entrega no GitHub)], "prints/atividade-9.png", largura: 85%)
  #evid([Atividade 9 — resultado: histórico de commits e datas das issues no repositório novo], "prints/comprovante-datas.png")

  *Dificuldades e como foram resolvidas.* Motivo do atraso: o repositório novo e a cópia do histórico só foram registrados na issue em 06/11, depois do prazo de 23/10. O histórico foi preservado integralmente, de modo que os commits das atividades 7 e 8 continuam localizáveis com o mesmo hash.
]

#atividade(
  10, "Seu negócio no ar — o domínio no lugar dos filmes",
  descricao: "Stack apontando para o repositório novo, tabelas e API do domínio, papéis do negócio, isolamento por usuário, eventos no log, upload e landing page.",
  planejada: "06/11/2026",
  realizada: "06/11/2026 21:16",
  situacao: "entregue",
  evidencia: "GitHub — issue de entrega (@siriani) + commit + URL no ar + prints da landing, do 403 e dos eventos no log",
  url: "https://github.com/luisciaramicoli/postcraft-ai/issues/8",
)[
  *O que foi feito.* Troquei o domínio de filmes pelo de posts e marcas: tabelas `marcas`, `posts` e `templates`, API do negócio, papéis `criador`, `revisor` e `admin`, isolamento por usuário nas consultas, eventos de negação no log-service, upload de logo e de foto no MinIO e a landing page. O commit é `ad95547d8667`, de 06/11/2026 21:15:56 (UTC−03:00); a issue de entrega foi aberta às 21:16 (00:16 UTC de 07/11).

  #evid([Atividade 10 — evidência da entrega (issue de entrega no GitHub)], "prints/atividade-10.png", largura: 85%)
  #evid([Atividade 10 — resultado: página inicial pública, capturada em 12/11/2026 às 21:56], "prints/publico-landing.png", largura: 90%)
  #evid([Atividade 10 — resultado: `/api/health` da URL pública (timestamp 2026-11-13T00:56:56Z, igual a 12/11/2026 21:56:56 em UTC−03:00)], "prints/publico-health.png", largura: 80%)
  #evid([Atividade 10 — resultado: 403 Forbidden no acesso e na exclusão de post de outro usuário e na rota de administração, com a conta B], "prints/atividade-10-403.png")
  #evid([Atividade 10 — resultado: eventos `tentativa_negada_403` e `cross_tenant_denied` no log-service (Redis Stream `audit_events`)], "prints/atividade-10-log.png")

  *Dificuldades e como foram resolvidas.* A issue de entrega informava apenas `localhost` como endereço; o site público só foi verificado depois, em 12/11/2026. Os prints do 403 e dos eventos de log foram feitos nessa data na stack local (porta 8218), com duas contas de teste do papel criador, e não no domínio público. A entrega do código foi no prazo.
]

#atividade(
  11, "SaaS completo — planos, limites e assinatura com Stripe",
  descricao: "Planos recorrentes, checkout de assinatura, webhooks atualizando o plano, portal do cliente, limites por plano na API e painel admin.",
  planejada: "13/11/2026",
  realizada: "12/11/2026 22:43",
  situacao: "entregue",
  evidencia: "GitHub — issue de entrega (@siriani) + commit + prints da assinatura com o cartão 4242, do Stripe em modo de teste, do webhook e do limite bloqueando",
  url: "https://github.com/luisciaramicoli/postcraft-ai/issues/10",
)[
  *O que foi feito.* Implementei o limite do plano gratuito no servidor: três posts gerados por mês, verificados antes de chamar o Gemini, com 403 e o código `limite_gratuito_atingido`; usuários premium não têm limite. O limite é coberto por teste automatizado (`tests/quota.test.js`, 3 testes). Em 12/11/2026, entre 22:23 e 22:28, executei o ciclo completo de assinatura numa conta de teste, com o Stripe em modo de teste e o cartão 4242: (1) no plano gratuito, a quarta geração foi bloqueada; (2) o checkout hospedado do Stripe aceitou o cartão 4242; (3) o webhook ativou o plano em cerca de 1 segundo e a quarta geração foi aceita; (4) o cancelamento da assinatura, às 22:28:06, devolveu a conta ao plano gratuito em cerca de 3 segundos e o bloqueio voltou. O teste rodou numa instância local do app, com o código do commit `f88b14000720` (12/11/2026 22:42); o webhook foi entregue pelo Stripe ao domínio público, e o app público gravou no banco compartilhado, o que é uma inferência pelo comportamento observado.

  #evid([Atividade 11 — passo 1: perfil no plano gratuito, antes da assinatura (12/11/2026 22:26)], "prints/11-perfil-gratuito.png", largura: 80%)
  #evid([Atividade 11 — passo 1: quarta geração do mês bloqueada na interface (12/11/2026 22:26)], "prints/11-limite-ui.png", largura: 80%)
  #evid([Atividade 11 — passo 2: checkout hospedado do Stripe, modo de teste, plano Creator Pro (12/11/2026 22:25)], "prints/11-stripe-checkout.png", largura: 80%)
  #evid([Atividade 11 — passo 2: cartão de teste 4242 preenchido antes de confirmar (12/11/2026 22:26)], "prints/11-stripe-cartao-4242.png", largura: 80%)
  #evid([Atividade 11 — passo 3: plano Creator Pro ativo após o webhook (12/11/2026 22:26)], "prints/11-perfil-apos-checkout.png", largura: 80%)
  #evid([Atividade 11 — passo 3: conta premium com o quarto post gerado, acima do limite gratuito (12/11/2026 22:28)], "prints/11-premium-4o-post.png", largura: 80%)
  #evid([Atividade 11 — webhook: eventos do cliente de teste no Stripe, com `pending_webhooks = 0` (consulta à API)], "prints/11-eventos-stripe.png")
  #evid([Atividade 11 — passo 4: perfil de volta ao plano gratuito após o cancelamento (12/11/2026 22:28)], "prints/11-perfil-apos-cancelamento.png", largura: 80%)
  #evid([Atividade 11 — passo 4: geração bloqueada novamente após o cancelamento (12/11/2026 22:28)], "prints/11-limite-apos-cancelamento.png", largura: 80%)
  #evid([Atividade 11 — teste automatizado do limite: `freeQuotaExceeded` e resultado de `tests/quota.test.js` (banco e Gemini simulados)], "prints/atividade-11-limite.png")

  *Dificuldades e como foram resolvidas.* O commit do limite de cota (`f88b14000720`, 22:42) e a issue de entrega (número 10, aberta às 22:43, 01:43 UTC de 13/11) foram registrados em 12/11/2026, um dia antes do prazo, depois dos testes do ciclo. Não estão prontos o portal do cliente (o cancelamento foi feito pela API do Stripe), o tratamento de eventos repetidos, o painel admin de assinaturas e a verificação de que o site público já executa o commit com a cota: a issue 8 registra a stack no commit `32b09ef`, anterior à cota, e não confirmei a atualização. Num teste anterior, o checkout do Stripe retornou erro de credencial expirada; o erro não se repetiu em 12/11 e a causa não foi investigada. O Stripe exibe o nome de negócio ClimaAgro porque a conta é compartilhada com outro projeto.
]

// ============================================================
= Considerações finais
// ============================================================
Neste bimestre aprendi a transformar um catálogo em um produto com cobrança, armazenamento, logs e domínio próprio, e, principalmente, a separar o que o código faz do que a interface apenas promete. Um botão de plano ou de geração não prova que a cobrança recorrente, a autorização e a cota funcionam; só o ciclo completo, da assinatura ao cancelamento, com um webhook de verdade, prova. O mais difícil foi manter versões diferentes alinhadas: o produto, a base de código, a imagem publicada e o que a stack pública executa nem sempre são a mesma coisa.

Faria diferente em três pontos: registraria a entrega de cada atividade no dia, com issue e commit, em vez de acumular; trataria a idempotência do webhook e o portal do cliente desde o primeiro desenho da assinatura; e guardaria os prints a cada marco, em vez de reconstruí-los depois.

Para ser um produto de verdade, o PostCraft AI ainda precisa de: publicação da versão com o limite de cota no site público e a conferência de que ela está no ar; portal do cliente e deduplicação de eventos de webhook; tratamento de falha de pagamento; troca dos segredos padrão do Compose de produção e HTTPS com cookie seguro; limites de memória nos containers; e testes de isolamento com mais de uma conta e papel.

// ============================================================
= Declaração de autoria
// ============================================================
Declaro que este relatório foi elaborado por mim, individualmente, e que as evidências apresentadas correspondem a entregas de minha autoria, verificáveis nos links informados. A redação e a montagem tiveram assistência de IA, como declarado na metodologia.

#v(1.5cm)
#grid(
  columns: (1fr, 1fr), gutter: 2cm,
  align(center)[#line(length: 100%, stroke: 0.5pt) \ #aluno],
  align(center)[#line(length: 100%, stroke: 0.5pt) \ Pompeia, #data-relatorio],
)
