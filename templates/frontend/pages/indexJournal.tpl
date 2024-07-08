{**
 * templates/frontend/pages/indexJournal.tpl
 *
 * Copyright (c) 2014-2021 Simon Fraser University
 * Copyright (c) 2003-2021 John Willinsky
 * Distributed under the GNU GPL v3. For full terms see the file docs/COPYING.
 *
 * @brief Display the index page for a journal
 *
 * @uses $currentJournal Journal This journal
 * @uses $journalDescription string Journal description from HTML text editor
 * @uses $homepageImage object Image to be displayed on the homepage
 * @uses $additionalHomeContent string Arbitrary input from HTML text editor
 * @uses $announcements array List of announcements
 * @uses $numAnnouncementsHomepage int Number of announcements to display on the
 *       homepage
 * @uses $issue Issue Current issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$currentJournal->getLocalizedName()}

<div class="page_index_journal">

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|@count}

		<section class="section cmp_announcements highlight_first">
			<a id="homepageAnnouncements"></a>
			{* <h2>
				{translate key="announcement.announcements"}
			</h2> *}
			<div class="glide" id="glide-announcements">
				<div class="glide__track mb-3" data-glide-el="track">
					<ul class="glide__slides">
						{foreach name=announcements from=$announcements item=announcement}
							{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
								{break}
							{/if}
							<li class="glide__slide">
								<article class="obj_announcement_summary">
									<h4>
										<a
											href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}">
											{$announcement->getLocalizedTitle()|escape}
										</a>
									</h4>
									<div class="date">
										{$announcement->getDatePosted()|date_format:$dateFormatShort}
									</div>
									<div class="summary has-text-justified">
										{$announcement->getLocalizedDescriptionShort()|strip_unsafe_html}
									</div>
									<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}"
											class="read_more">
											<span class="tag" aria-hidden="true" role="presentation">
												{translate key="common.readMore"}
											</span>
											<span class="pkp_screen_reader">
												{translate key="common.readMoreWithTitle" title=$announcement->getLocalizedTitle()|escape}
											</span>
										</a>
								</article>
							</li>
						{/foreach}
					</ul>
				</div>
				{* <div class="glide__arrows" data-glide-el="controls">
					<button class="glide__arrow glide__arrow--left" data-glide-dir="<">
						<span class="icon">
							<i class="fas fa-arrow-left"></i>
						</span>
					</button>
					<button class="glide__arrow glide__arrow--right" data-glide-dir=">"><span class="icon">
							<i class="fas fa-arrow-right"></i>
						</span></button>
				</div> *}
				<div class="glide__bullets slider__bullets buttons is-centered" data-glide-el="controls[nav]">
					{foreach name=announcements from=$announcements item=announcement}
						<button class="slider__bullet glide__bullet"
							data-glide-dir="={$smarty.foreach.announcements.iteration - 1}">
							{* <span class="icon">
							<i class="fas fa-envelope-square"></i>
						</span> *}
						</button>
					{/foreach}
				</div>
			</div>
		</section>
	{/if}



	{* Latest issue *}
	{if $issue}
		<section class="section current_issue">
			<a id="homepageIssue"></a>
			<h1>
				{translate key="journal.currentIssue"}
			</h1>

			{include file="frontend/objects/issue_toc.tpl" heading="h2" showTitle="true"}
			<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="issue" op="archive"}" class="read_more button is-primary">
				{translate key="journal.viewAllIssues"}
			</a>

			<div class="divider is-right"></div>
		</section>
	{/if}

	{* Additional Homepage Content *}
	{if $additionalHomeContent}
		<div class="section additional_content">
			{$additionalHomeContent}
		</div>
	{/if}
</div><!-- .page -->

{include file="frontend/components/footer.tpl"}