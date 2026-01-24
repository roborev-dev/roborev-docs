import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://roborev.io',
  integrations: [
    starlight({
      title: 'roborev',
      logo: {
        src: './src/assets/logo-transparent.svg',
      },
      disable404Route: false,
      components: {
        ThemeSelect: './src/components/EmptyThemeSelect.astro',
        Header: './src/components/Header.astro',
      },
      customCss: ['./src/styles/custom.css'],
      expressiveCode: {
        themes: ['dracula'],
        styleOverrides: {
          copyButton: {
            visible: true,
          },
        },
      },
      social: {
        github: 'https://github.com/roborev-dev/roborev',
      },
      head: [
        // Open Graph / Social preview
        {
          tag: 'meta',
          attrs: { property: 'og:image', content: 'https://roborev.io/og-image.png' },
        },
        {
          tag: 'meta',
          attrs: { property: 'og:image:width', content: '1200' },
        },
        {
          tag: 'meta',
          attrs: { property: 'og:image:height', content: '630' },
        },
        {
          tag: 'meta',
          attrs: { property: 'og:type', content: 'website' },
        },
        {
          tag: 'meta',
          attrs: { name: 'twitter:card', content: 'summary_large_image' },
        },
        {
          tag: 'meta',
          attrs: { name: 'twitter:image', content: 'https://roborev.io/og-image.png' },
        },
        // Mermaid for diagrams (client-side)
        {
          tag: 'script',
          attrs: {
            type: 'module',
          },
          content: `
            import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11.4.0/dist/mermaid.esm.min.mjs';
            mermaid.initialize({
              startOnLoad: true,
              theme: 'dark',
              themeVariables: {
                primaryColor: '#0d3331',
                primaryTextColor: '#00ff9f',
                primaryBorderColor: '#333333',
                lineColor: '#00ff9f',
                secondaryColor: '#1a1a1a',
                tertiaryColor: '#0f0f0f',
                background: '#0a0a0a',
                mainBkg: '#0f0f0f',
                nodeBorder: '#333333',
                clusterBkg: '#1a1a1a',
                titleColor: '#00ff9f',
                edgeLabelBackground: '#0f0f0f'
              }
            });
          `,
        },
      ],
      sidebar: [
        { label: 'Quick Start', slug: 'quickstart' },
        { label: 'Installation', slug: 'installation' },
        { label: 'CLI Commands', slug: 'commands' },
        { label: 'Terminal UI', slug: 'integrations/tui' },
        {
          label: 'Guides',
          items: [
            { label: 'Responding to Reviews', slug: 'guides/responding-to-reviews' },
            { label: 'Reviewing Branches', slug: 'guides/reviewing-branches' },
            { label: 'Reviewing Uncommitted Changes', slug: 'guides/reviewing-dirty' },
            { label: 'Custom Tasks', slug: 'guides/custom-tasks' },
            { label: 'Auto-Fixing with Refine', slug: 'guides/auto-fixing' },
            { label: 'Agent Skills', slug: 'guides/agent-skills' },
            { label: 'Repository Management', slug: 'guides/repository-management' },
            { label: 'PostgreSQL Sync', slug: 'integrations/postgres-sync' },
          ],
        },
        {
          label: 'Configuration',
          items: [
            { label: 'Overview', slug: 'configuration' },
            { label: 'Per-Repository', slug: 'configuration/per-repo' },
            { label: 'Global', slug: 'configuration/global' },
            { label: 'Authentication', slug: 'configuration/authentication' },
            { label: 'Reasoning Levels', slug: 'configuration/reasoning-levels' },
          ],
        },
        {
          label: 'Agents',
          items: [
            { label: 'Supported Agents', slug: 'agents' },
            { label: 'Review vs Agentic Modes', slug: 'agents/modes' },
          ],
        },
        {
          label: 'Integrations',
          items: [
            { label: 'Event Streaming', slug: 'integrations/streaming' },
            { label: 'Git Worktrees', slug: 'integrations/git-worktrees' },
          ],
        },
        { label: 'Development', slug: 'development' },
      ],
    }),
  ],
});
