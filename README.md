# Affiliate Agents Project

A distributed affiliate tracking system with 1,000 unique agent pages, each with QR code support for easy mobile access.

## Overview

This project creates individual tracking pages for affiliate marketing campaigns. Each agent (AGENT4001 through AGENT5000) has:
- A dedicated HTML landing page
- A unique QR code for mobile tracking
- Individual affiliate tracking parameters

## Features

- 1,000 unique agent pages
- QR code generation for each agent
- GitHub Pages ready deployment
- Mobile-responsive design
- Simple affiliate link tracking

## Installation

### Prerequisites

- Git
- A GitHub account
- Web browser (for testing)

### Quick Start

#### macOS Installation

```bash
# Clone the repository
git clone https://github.com/Janady13/affiliate-agents.git
cd affiliate-agents

# Run the setup script
chmod +x scripts/setup-macos.sh
./scripts/setup-macos.sh
```

#### Linux Installation

```bash
# Clone the repository
git clone https://github.com/Janady13/affiliate-agents.git
cd affiliate-agents

# Run the setup script
chmod +x scripts/setup-linux.sh
./scripts/setup-linux.sh
```

#### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/Janady13/affiliate-agents.git
   cd affiliate-agents
   ```

2. Enable GitHub Pages:
   - Go to your repository settings on GitHub
   - Navigate to "Pages" section
   - Select branch: `main` (or your default branch)
   - Select folder: `/ (root)`
   - Click "Save"

3. Your site will be available at:
   ```
   https://janady13.github.io/affiliate-agents/
   ```

## Usage

### Accessing Agent Pages

Each agent has a unique URL:
```
https://janady13.github.io/affiliate-agents/AGENT4001/
https://janady13.github.io/affiliate-agents/AGENT4002/
...
https://janady13.github.io/affiliate-agents/AGENT5000/
```

### Customizing Affiliate Links

To customize the affiliate offer URLs:

1. Edit the agent HTML files
2. Replace `https://example.com/offer?sid=AGENTXXXX` with your actual affiliate URL
3. Update the tracking pixel if needed

Example:
```html
<a href="https://your-affiliate-network.com/offer?sid=AGENT4001" target="_blank" rel="noopener noreferrer">
  Your Offer
</a>
```

### Generating New Agents

Use the provided generator script:

```bash
# Generate new agents
chmod +x scripts/generate-agents.sh
./scripts/generate-agents.sh 5001 5100  # Creates AGENT5001 to AGENT5100
```

## Project Structure

```
affiliate-agents/
├── .nojekyll              # Tells GitHub Pages not to use Jekyll
├── .gitignore             # Git ignore rules
├── README.md              # This file
├── index.html             # Main landing page (optional)
├── scripts/               # Utility scripts
│   ├── setup-macos.sh     # macOS setup script
│   ├── setup-linux.sh     # Linux setup script
│   └── generate-agents.sh # Agent generation script
└── AGENT4001/             # Agent folders (4001-5000)
    ├── index.html         # Agent landing page
    └── qr.png             # QR code for agent
```

## GitHub Pages Configuration

The repository is configured to work with GitHub Pages out of the box:

1. The `.nojekyll` file ensures proper serving of folders starting with underscores or dots
2. All agent pages are self-contained with no build process required
3. Static HTML ensures fast loading and high reliability

## Tracking and Analytics

To add tracking to your affiliate pages:

1. **Google Analytics**: Add your GA4 tracking code to each agent page
2. **Facebook Pixel**: Add your pixel code to track conversions
3. **Custom Tracking**: Implement your own tracking parameters

Example for Google Analytics:
```html
<!-- Add to each agent's index.html before </body> -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## Development

### Local Testing

You can test locally using any simple HTTP server:

#### Python 3
```bash
python3 -m http.server 8000
```

#### Python 2
```bash
python -m SimpleHTTPServer 8000
```

#### Node.js
```bash
npx http-server -p 8000
```

Then visit `http://localhost:8000/AGENT4001/` to test an agent page.

## Deployment

### Automated Deployment

Changes pushed to the main branch will automatically deploy to GitHub Pages.

```bash
git add .
git commit -m "Update agent pages"
git push origin main
```

### Manual Deployment

GitHub Pages automatically serves the content from your repository. No manual deployment steps are needed beyond pushing your changes.

## Troubleshooting

### Pages Not Loading

1. Verify GitHub Pages is enabled in repository settings
2. Check that the source branch is correct
3. Wait 1-2 minutes for GitHub to build and deploy changes
4. Clear browser cache and try again

### QR Codes Not Displaying

1. Ensure `qr.png` files exist in each agent folder
2. Check file permissions are correct
3. Verify image files are properly committed to git

### Custom Domain Issues

If using a custom domain:
1. Add CNAME record pointing to `janady13.github.io`
2. Create CNAME file in repository root with your domain
3. Enable HTTPS in GitHub Pages settings

## Security Considerations

- All affiliate links use `rel="noopener noreferrer"` for security
- No user data is collected or stored by this system
- Tracking is handled by external affiliate networks

## Performance

- Lightweight HTML pages load in <100ms
- No JavaScript frameworks required
- Optimized for mobile devices
- QR codes enable instant mobile access

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Submit a pull request

## License

This project is provided as-is for affiliate marketing purposes.

## Support

For issues and questions:
- Open an issue on GitHub
- Check existing documentation
- Review GitHub Pages documentation

## Changelog

### Version 1.0.0 (2025-10-30)
- Initial release with 1,000 agent pages
- GitHub Pages integration
- QR code support
- macOS and Linux installation scripts

## Roadmap

- [ ] Custom domain support documentation
- [ ] Bulk agent generation tool
- [ ] Analytics dashboard
- [ ] A/B testing framework
- [ ] Mobile app integration

---

Built with GitHub Pages | Deployed at: https://janady13.github.io/affiliate-agents/
