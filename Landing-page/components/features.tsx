import { Card, CardContent } from "@/components/ui/card"
import { FileText, Terminal, Palette, Zap } from "lucide-react"
import Image from "next/image"

const features = [
  {
    icon: FileText,
    title: "One-Click File Creation",
    description: "Create new files instantly by clicking anywhere in Finder or on your desktop. No more navigating through menus.",
  },
  {
    icon: Palette,
    title: "Custom Templates",
    description: "Define your own file templates for any file type. Create pre-filled documents, code snippets, or any content you need.",
  },
  {
    icon: Terminal,
    title: "Terminal Integration",
    description: "Open the current directory in Terminal with a single click. A simple but powerful feature macOS lacks natively.",
  },
  {
    icon: Zap,
    title: "Native Performance",
    description: "Built with Swift for macOS 14+, ensuring lightning-fast performance and seamless system integration.",
  },
]

const screenshots = [
  {
    src: "https://github.com/user-attachments/assets/de2b4a0b-814d-4553-af4d-bb72158353b3",
    alt: "Context menu showing file creation options",
  },
  {
    src: "https://github.com/user-attachments/assets/a625acfc-2e50-458b-9f20-01585f144a76",
    alt: "File templates configuration",
  },
  {
    src: "https://github.com/user-attachments/assets/47dc96d4-7a45-447a-9466-edc58a7f9b99",
    alt: "Finder integration in action",
  },
]

export function Features() {
  return (
    <section className="relative px-4 py-24">
      <div className="mx-auto max-w-6xl">
        {/* Section Header */}
        <div className="mb-16 text-center">
          <h2 className="mb-4 text-3xl font-bold tracking-tight text-foreground sm:text-4xl">
            Powerful Features,{" "}
            <span className="text-primary">Simple Interface</span>
          </h2>
          <p className="mx-auto max-w-2xl text-muted-foreground">
            Everything you need to supercharge your Finder workflow, without the complexity.
          </p>
        </div>

        {/* Features Grid */}
        <div className="mb-20 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {features.map((feature) => (
            <Card key={feature.title} className="border-border/50 bg-card/50 backdrop-blur-sm transition-colors hover:border-primary/30">
              <CardContent className="p-6">
                <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-lg bg-primary/10">
                  <feature.icon className="h-6 w-6 text-primary" />
                </div>
                <h3 className="mb-2 font-semibold text-foreground">{feature.title}</h3>
                <p className="text-sm text-muted-foreground">{feature.description}</p>
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Screenshots Gallery */}
        <div className="mb-8 text-center">
          <h3 className="mb-2 text-2xl font-bold text-foreground">See It in Action</h3>
          <p className="text-muted-foreground">Screenshots showcasing the app&apos;s intuitive interface</p>
        </div>

        <div className="grid gap-6 md:grid-cols-3">
          {screenshots.map((screenshot, index) => (
            <div key={index} className="group relative overflow-hidden rounded-xl border border-border/50 bg-card/30 transition-all hover:border-primary/30">
              <Image
                src={screenshot.src}
                alt={screenshot.alt}
                width={500}
                height={360}
                className="w-full object-cover transition-transform group-hover:scale-[1.02]"
              />
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
