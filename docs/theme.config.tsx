import { useRouter } from "next/router";
import { DocsThemeConfig, useConfig } from "nextra-theme-docs";

const config: DocsThemeConfig = {
  logo: <span>AllyDB Docs</span>,
  project: {
    link: "https://github.com/Allyedge/allydb",
  },
  docsRepositoryBase: "https://github.com/Allyedge/allydb",
  footer: {
    text: (
      <span>
        Apache 2.0 {new Date().getFullYear()} ©{" "}
        <a href="https://allydb.vercel.app/" target="_blank">
          AllyDB Docs
        </a>
        .
      </span>
    ),
  },
  navigation: {
    prev: true,
    next: true,
  },
  useNextSeoProps() {
    const { route } = useRouter();

    if (route !== "/") {
      return {
        titleTemplate: "%s - AllyDB",
      };
    }

    return {
      titleTemplate: "AllyDB",
    };
  },
  head: () => {
    const { asPath } = useRouter();
    const { frontMatter } = useConfig();

    return (
      <>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta
          property="og:url"
          content={`https://allydb.vercel.app${asPath}`}
        />
        <meta property="og:title" content={frontMatter.title || "AllyDB"} />
        <meta
          property="og:description"
          content={frontMatter.description || "Documentation for AllyDB."}
        />
      </>
    );
  },
};

export default config;
