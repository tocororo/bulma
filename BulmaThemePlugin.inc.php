<?php

/**
 * @file plugins/themes/default/BulmaThemePlugin.php
 *
 * Copyright (c) 2024 Rafael Martínez Estévez
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @class BulmaThemePlugin
 * @ingroup plugins_themes_bulma
 *
 * @brief Default theme
 */

import('lib.pkp.classes.plugins.ThemePlugin');


class BulmaThemePlugin extends ThemePlugin
{
	/**
	 * Initialize the theme's styles, scripts and hooks. This is only run for
	 * the currently active theme.
	 *
	 * @return null
	 */
	public function init()
	{
		$this->addStyle(
			'bulma', 'resources/main.css'
		);


		// Styles for HTML galleys
		$this->addStyle('htmlGalley', 'templates/plugins/generic/htmlArticleGalley/css/default.css', array('contexts' => 'htmlGalley'));


		$this->addMenuArea(array('primary', 'user'));

		$request = Application::get()->getRequest();
		$min = Config::getVar('general', 'enable_minified') ? '.min' : '';
		$jquery = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jquery/jquery' . $min . '.js';
		$jqueryUI = $request->getBaseUrl() . '/lib/pkp/lib/vendor/components/jqueryui/jquery-ui' . $min . '.js';
		// Use an empty `baseUrl` argument to prevent the theme from looking for
		// the files within the theme directory
		$this->addScript('jQuery', $jquery, array('baseUrl' => ''));
		// $this->addScript('jQueryUI', $jqueryUI, array('baseUrl' => ''));

		$this->addScript('menu', 'resources/js/all.js');
		// $this->addScript('collapsable', '/resources/js/collapsable.js');
		// $this->addScript('search', '/resources/js/search.js');
		// $this->addScript('collapsible', '/resources/collapsible/bulma-collapsible.min.js');

		$this->addOption('showDescriptionInJournalIndex', 'FieldOptions', [
			'label' => __('manager.setup.contextSummary'),
				'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.default.option.showDescriptionInJournalIndex.option'),
				],
			],
			'default' => false,
		]);
		$this->addOption('useHomepageImageAsHeader', 'FieldOptions', [
			'label' => __('manager.setup.contextSummary'),
				'options' => [
				[
					'value' => true,
					'label' => __('plugins.themes.default.option.useHomepageImageAsHeader.option'),
				],
			],
			'default' => false,
		]);

		HookRegistry::register ('TemplateManager::display', array($this, 'loadAdditionalData'));


		// Check if CSS embedded to the HTML galley
		HookRegistry::register('TemplateManager::display', array($this, 'hasEmbeddedCSS'));
		
	}

	public function loadAdditionalData($hookName, $args) {
		$smarty = $args[0];

		$request = $this->getRequest();
		$context = $request->getContext();

		if (!defined('SESSION_DISABLE_INIT')) {

			// Get possible locales
			if ($context) {
				$locales = $context->getSupportedLocaleNames();
			} else {
				$locales = $request->getSite()->getSupportedLocaleNames();
			}

			// $orcidImageUrl = $this->getPluginPath() . '/' . ORCID_IMAGE_URL;

			$smarty->assign(array(
				'languageToggleLocales' => $locales,
				// 'orcidImageUrl' =>  $orcidImageUrl,
			));
		}
	}

	/**
	 * Get the display name of this plugin
	 * @return string
	 */
	function getDisplayName()
	{
		return __('plugins.themes.bulma.name');
	}

	/**
	 * Get the description of this plugin
	 * @return string
	 */
	function getDescription()
	{
		return __('plugins.themes.bulma.description');
	}


	/**
	 * @param $hookName string `TemplateManager::display`
	 * @param $args array [
	 *      @option TemplateManager
	 *      @option string relative path to the template
	 *  ]
	 */
	public function hasEmbeddedCSS($hookName, $args) {
		$templateMgr = $args[0]; /* @var $templateMgr TemplateManager */
		$template = $args[1];
		$request = $this->getRequest();

		// Return false if not a galley page
		if ($template !== 'plugins/plugins/generic/htmlArticleGalley/generic/htmlArticleGalley:display.tpl') return false;

		$articleArrays = $templateMgr->getTemplateVars('article');

		// Deafult styling for HTML galley
		$boolEmbeddedCss = false;
		foreach ($articleArrays->getGalleys() as $galley) {
			if ($galley->getFileType() === 'text/html') {
				$submissionFile = $galley->getFile();

				$submissionFileDao = DAORegistry::getDAO('SubmissionFileDAO');
				import('lib.pkp.classes.submission.SubmissionFile'); // Constants
				$embeddableFiles = array_merge(
					$submissionFileDao->getLatestRevisions($submissionFile->getSubmissionId(), SUBMISSION_FILE_PROOF),
					$submissionFileDao->getLatestRevisionsByAssocId(ASSOC_TYPE_SUBMISSION_FILE, $submissionFile->getFileId(), $submissionFile->getSubmissionId(), SUBMISSION_FILE_DEPENDENT)
				);

				foreach ($embeddableFiles as $embeddableFile) {
					if ($embeddableFile->getFileType() == 'text/css') {
						$boolEmbeddedCss = true;
					}
				}
			}

		}

		$templateMgr->assign(array(
			'boolEmbeddedCss' => $boolEmbeddedCss,
			'themePath' => $request->getBaseUrl() . "/" . $this->getPluginPath(),
		));
	}
}
