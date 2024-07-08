{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

	</div><!-- pkp_structure_main -->
</div><!-- pkp_structure_content -->

	{* Sidebars *}
	{if empty($isFullWidth)}
		{capture assign="sidebarCode"}{call_hook name="Templates::Common::Sidebar"}{/capture}
		{if $sidebarCode}
		<div class="column is-one-third-desktop pkp_structure_sidebar">
			<div class="block left" role="complementary" aria-label="{translate|escape key="common.navigation.sidebar"}">
				{$sidebarCode}
			</div><!-- pkp_sidebar.left -->
		</div>
		{/if}
	{/if}


</div><!-- columns -->

<footer class=" pkp_structure_footer_wrapper footer has-background-primary has-text-white" role="contentinfo">
	<a id="pkp_content_footer"></a>

	<div class="container  pkp_structure_footer">

		{if $pageFooter}
			<div class="pkp_footer_content has-text-white">
				{$pageFooter}
			</div>
		{/if}


		<div class="divider is-right"></div>

		<div class="pkp_brand_footer content has-text-centered" role="complementary">
		<div class="columns is-desktop">
  			<div class="column is-4 is-offset-4">
			  <a href="https://ugs.ed.ao/" target="_blank" rel="noopener">
			  <figure class="image">
				  <img src="{$baseUrl}/plugins/themes/bulma/logo_footer.png"  {if $thumb.altText}
					  alt="{$thumb.altText|escape}" {/if}>
			  </figure>
		  </a>
		  </div>
		</div>
			<div class="footer-social has-text-centered has-text-white">

				{if $activeTheme->getOption('facebookLink') }
					<a class="tag is-large is-primary" href="{$activeTheme->getOption('facebookLink')}" target="_blank"
						rel="noopener">
						<span class="icon is-large">
							<i class="fab fa-facebook-square fa-lg"></i>
						</span>
					</a>
				{/if}
				{if $activeTheme->getOption('twitterLink') }
					<a class="tag is-large is-primary" href="{$activeTheme->getOption('twitterLink')}" target="_blank"
						rel="noopener">
						<span class="icon is-large">
							<i class="fab fa-twitter-square fa-lg"></i>
						</span>
					</a>
				{/if}
				{if $activeTheme->getOption('linkedinLink') }
					<a class="tag is-large is-primary" href="{$activeTheme->getOption('linkedinLink')}" target="_blank"
						rel="noopener">
						<span class="icon is-large">
							<i class="fab fa-linkedin fa-lg"></i>
						</span>
					</a>
				{/if}
				{if $activeTheme->getOption('instagramLink') }
					<a class="tag is-large is-primary" href="{$activeTheme->getOption('instagramLink')}" target="_blank"
						rel="noopener">
						<span class="icon is-large">
							<i class="fab fa-instagram-square fa-lg"></i>
						</span>
					</a>
				{/if}
				{if $activeTheme->getOption('youtubeLink') }
					<a class="tag is-large is-primary" href="{$activeTheme->getOption('youtubeLink')}" target="_blank"
						rel="noopener">
						<span class="icon is-large">
							<i class="fab fa-youtube-square fa-lg"></i>
						</span>
					</a>
				{/if}

			</div>
		</div>
	</div>
</footer><!-- pkp_structure_footer_wrapper -->

</div><!-- pkp_structure_page -->

{load_script context="frontend"}

{call_hook name="Templates::Common::Footer::PageFooter"}
</body>
</html>
