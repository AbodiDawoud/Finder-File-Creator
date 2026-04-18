import { Button } from "@/components/ui/button"
import { Github, Download, Coffee } from "lucide-react"
import Image from "next/image"

export function Hero() {
  return (
    <section className="relative min-h-screen flex items-center justify-center overflow-hidden px-4 py-20">
      {/* Background gradient */}
      <div className="absolute inset-0 bg-gradient-to-b from-primary/5 via-transparent to-transparent" />
      
      <div className="relative z-10 mx-auto max-w-6xl text-center">
        {/* App Icon */}
        <div className="mb-8 flex justify-center">
          <div className="relative">
            <div className="absolute -inset-4 rounded-3xl bg-primary/20 blur-2xl" />
            <Image
              src="https://github.com/user-attachments/assets/5b94e02d-2916-403f-8b08-cca1b82b0394"
              alt="Finder File Creator App Icon"
              width={140}
              height={140}
              className="relative rounded-[28px] shadow-2xl"
            />
          </div>
        </div>

        {/* Badges */}
        <div className="mb-6 flex flex-wrap justify-center gap-2">
          <span className="inline-flex items-center gap-1.5 rounded-full bg-secondary px-3 py-1 text-xs font-medium text-secondary-foreground">
            <svg className="h-3.5 w-3.5" viewBox="0 0 24 24" fill="currentColor">
              <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.81-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
            </svg>
            macOS 14+
          </span>
          <span className="inline-flex items-center gap-1.5 rounded-full bg-secondary px-3 py-1 text-xs font-medium text-secondary-foreground">
            <svg className="h-3.5 w-3.5" viewBox="0 0 24 24" fill="#F05138">
              <path d="M7.2 3.6c3.9 2.7 6.6 7.1 6.6 7.1s-.5-.3-1.4-.7c-2.1-.9-4.3-.7-4.3-.7.2.1 1.7 1.3 2.4 2 3.5 3.6 4.8 8.6 2.9 12.6 0 0-.7-1.9-3.1-4.1-1.4-1.3-3.1-2.2-4.6-2.8-.2-.1-.4-.2-.6-.2 1.9 1.9 3.1 4.1 3.4 5.8 0 0-2.8-1.8-4.8-5.1C2 14.2 1.4 10.6 3 7.6c.8-1.5 2.4-2.9 4.2-4z"/>
            </svg>
            Swift 5
          </span>
          <span className="inline-flex items-center gap-1.5 rounded-full bg-secondary px-3 py-1 text-xs font-medium text-secondary-foreground">
            MIT License
          </span>
        </div>

        {/* Title */}
        <h1 className="mb-4 text-balance text-4xl font-bold tracking-tight text-foreground sm:text-5xl md:text-6xl lg:text-7xl">
          Finder File{" "}
          <span className="text-primary">Creator</span>
        </h1>

        {/* Description */}
        <p className="mx-auto mb-8 max-w-2xl text-balance text-lg text-muted-foreground sm:text-xl">
          Create new files with a single click anywhere in Finder or on your desktop. 
          Fully customizable templates and seamless terminal integration for macOS.
        </p>

        {/* CTA Buttons */}
        <div className="flex flex-wrap justify-center gap-4">
          <Button asChild size="lg" className="gap-2 font-semibold">
            <a href="https://github.com/AbodiDawoud/FinderFC" target="_blank" rel="noopener noreferrer">
              <Github className="h-5 w-5" />
              View on GitHub
            </a>
          </Button>
          <Button asChild variant="secondary" size="lg" className="gap-2 font-semibold">
            <a href="https://github.com/AbodiDawoud/FinderFC/releases" target="_blank" rel="noopener noreferrer">
              <Download className="h-5 w-5" />
              Download
            </a>
          </Button>
          <Button asChild variant="outline" size="lg" className="gap-2 font-semibold border-primary/30 hover:bg-primary/10">
            <a href="https://buymeacoffee.com/abodi" target="_blank" rel="noopener noreferrer">
              <Coffee className="h-5 w-5" />
              Support
            </a>
          </Button>
        </div>

        {/* Main Screenshot */}
        <div className="mt-16 flex justify-center">
          <div className="relative">
            <div className="absolute -inset-4 rounded-xl bg-primary/10 blur-3xl" />
            <Image
              src="https://github.com/user-attachments/assets/c6375a77-7c41-441f-a627-0ed50fb657be"
              alt="Finder File Creator App Preview"
              width={900}
              height={600}
              className="relative rounded-xl border border-border shadow-2xl"
              priority
            />
          </div>
        </div>
      </div>
    </section>
  )
}
