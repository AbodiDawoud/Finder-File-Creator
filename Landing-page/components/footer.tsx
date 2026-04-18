import { Github, Heart } from "lucide-react"

export function Footer() {
  return (
    <footer className="border-t border-border/50 px-4 py-8">
      <div className="mx-auto flex max-w-6xl flex-col items-center justify-between gap-4 sm:flex-row">
        <p className="flex items-center gap-1 text-sm text-muted-foreground">
          Made with <Heart className="h-4 w-4 text-primary" /> by{" "}
          <a 
            href="https://github.com/AbodiDawoud" 
            target="_blank" 
            rel="noopener noreferrer"
            className="font-medium text-foreground hover:text-primary transition-colors"
          >
            Abodi
          </a>
        </p>
        <div className="flex items-center gap-4">
          <a
            href="https://github.com/AbodiDawoud/FinderFC"
            target="_blank"
            rel="noopener noreferrer"
            className="flex items-center gap-2 text-sm text-muted-foreground transition-colors hover:text-foreground"
          >
            <Github className="h-4 w-4" />
            GitHub
          </a>
          <span className="text-muted-foreground/50">|</span>
          <span className="text-sm text-muted-foreground">MIT License</span>
        </div>
      </div>
    </footer>
  )
}
