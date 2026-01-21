import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
  site: 'https://roborev.io',
  integrations: [
    starlight({
      title: 'roborev',
      customCss: ['./src/styles/custom.css'],
      social: {
        github: 'https://github.com/roborev-dev/roborev',
      },
      head: [
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
        { label: 'Commands', slug: 'commands' },
        {
          label: 'Guides',
          items: [
            { label: 'Reviewing Branches', slug: 'guides/reviewing-branches' },
            { label: 'Reviewing Uncommitted Changes', slug: 'guides/reviewing-dirty' },
            { label: 'Ad-Hoc Prompts', slug: 'guides/ad-hoc-prompts' },
            { label: 'Auto-Fixing with Refine', slug: 'guides/auto-fixing' },
            { label: 'Agent Skills', slug: 'guides/agent-skills' },
            { label: 'Repository Management', slug: 'guides/repository-management' },
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
            { label: 'Terminal UI (TUI)', slug: 'integrations/tui' },
            { label: 'Event Streaming', slug: 'integrations/streaming' },
            { label: 'Git Worktrees', slug: 'integrations/git-worktrees' },
            { label: 'PostgreSQL Sync', slug: 'integrations/postgres-sync' },
          ],
        },
        { label: 'Development', slug: 'development' },
      ],
    }),
  ],
});
