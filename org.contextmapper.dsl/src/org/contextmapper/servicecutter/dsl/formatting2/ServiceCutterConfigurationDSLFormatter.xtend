/*
 * Copyright 2018 The Context Mapper Project Team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.contextmapper.servicecutter.dsl.formatting2

import com.google.inject.Inject
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.Characteristic
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.Compatibilities
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.Entity
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.RelatedGroup
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.ServiceCutterUserRepresentationsModel
import org.contextmapper.servicecutter.dsl.serviceCutterConfigurationDSL.UseCase
import org.contextmapper.servicecutter.dsl.services.ServiceCutterConfigurationDSLGrammarAccess
import org.eclipse.xtext.formatting2.AbstractFormatter2
import org.eclipse.xtext.formatting2.IFormattableDocument

class ServiceCutterConfigurationDSLFormatter extends AbstractFormatter2 {
	
	@Inject extension ServiceCutterConfigurationDSLGrammarAccess

	def dispatch void format(ServiceCutterUserRepresentationsModel serviceCutterUserRepresentationsModel, extension IFormattableDocument document) {
		for (useCase : serviceCutterUserRepresentationsModel.useCases) {
			useCase.format
		}
		serviceCutterUserRepresentationsModel.compatibilities.format
		for (aggregate : serviceCutterUserRepresentationsModel.aggregates) {
			aggregate.format
		}
		for (entity : serviceCutterUserRepresentationsModel.entities) {
			entity.format
		}
		for (predefinedService : serviceCutterUserRepresentationsModel.predefinedServices) {
			predefinedService.format
		}
		for (securityAccessGroup : serviceCutterUserRepresentationsModel.securityAccessGroups) {
			securityAccessGroup.format
		}
		for (separatedSecurityZone : serviceCutterUserRepresentationsModel.separatedSecurityZones) {
			separatedSecurityZone.format
		}
		for (sharedOwnerGroup : serviceCutterUserRepresentationsModel.sharedOwnerGroups) {
			sharedOwnerGroup.format
		}
	}
	
	def dispatch void format(UseCase useCase, extension IFormattableDocument document) {
		interior(
			useCase.regionFor.ruleCallTo(OPENRule).append[newLine],
			useCase.regionFor.ruleCallTo(CLOSERule).prepend[newLine].append[newLine]
		)[indent]
		
		useCase.regionFor.assignment(useCaseAccess.docAssignment_0).append[newLine]		
		useCase.regionFor.keyword('UseCase').prepend[newLine]
		useCase.regionFor.keyword('reads').prepend[newLine]
		useCase.regionFor.keyword('writes').prepend[newLine]
	}
	
	def dispatch void format(Entity entity, extension IFormattableDocument document) {
		interior(
			entity.regionFor.ruleCallTo(OPENRule).append[newLine],
			entity.regionFor.ruleCallTo(CLOSERule).prepend[newLine].append[newLine]
		)[indent]
		
		entity.regionFor.keyword('Entity').prepend[newLine]
	}
	
	def dispatch void format(RelatedGroup relatedGroup, extension IFormattableDocument document) {
		interior(
			relatedGroup.regionFor.ruleCallTo(OPENRule).append[newLine],
			relatedGroup.regionFor.ruleCallTo(CLOSERule).prepend[newLine].append[newLine]
		)[indent]
		
		relatedGroup.regionFor.assignment(aggregateAccess.docAssignment_0).append[newLine]
		relatedGroup.regionFor.assignment(entityAccess.docAssignment_0).append[newLine]
		relatedGroup.regionFor.assignment(predefinedServiceAccess.docAssignment_0).append[newLine]
		relatedGroup.regionFor.assignment(securityAccessGroupAccess.docAssignment_0).append[newLine]
		relatedGroup.regionFor.assignment(separatedSecurityZoneAccess.docAssignment_0).append[newLine]
		relatedGroup.regionFor.assignment(sharedOwnerGroupAccess.docAssignment_0).append[newLine]
	}
	
	def dispatch void format(Characteristic characteristic, extension IFormattableDocument document) {
		characteristic.regionFor.assignment(structuralVolatilityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		characteristic.regionFor.assignment(availabilityCriticalityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		characteristic.regionFor.assignment(consistencyCriticalityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		characteristic.regionFor.assignment(contentVolatilityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		characteristic.regionFor.assignment(storageSimilarityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		characteristic.regionFor.assignment(securityCriticalityAccess.nanoentitiesAssignment_3_2_0).prepend[newLine]
		
		interior(
			characteristic.regionFor.ruleCallTo(OPENRule).append[newLine],
			characteristic.regionFor.ruleCallTo(CLOSERule).prepend[newLine].append[newLine]
		)[indent]
		
		characteristic.regionFor.assignment(structuralVolatilityAccess.docAssignment_0).append[newLine]
		characteristic.regionFor.assignment(availabilityCriticalityAccess.docAssignment_0).append[newLine]
		characteristic.regionFor.assignment(consistencyCriticalityAccess.docAssignment_0).append[newLine]
		characteristic.regionFor.assignment(contentVolatilityAccess.docAssignment_0).append[newLine]
		characteristic.regionFor.assignment(storageSimilarityAccess.docAssignment_0).append[newLine]
		characteristic.regionFor.assignment(securityCriticalityAccess.docAssignment_0).append[newLine]
	}

	def dispatch void format(Compatibilities compatibilities, extension IFormattableDocument document) {
		interior(
			compatibilities.regionFor.ruleCallTo(OPENRule).append[newLine],
			compatibilities.regionFor.ruleCallTo(CLOSERule).prepend[newLine].append[newLine]
		)[indent]
		
		compatibilities.regionFor.assignment(compatibilitiesAccess.docAssignment_1).append[newLine]
		
		for (availabilityCriticality : compatibilities.availabilityCriticality) {
			availabilityCriticality.format
		}
		for (consistencyCriticality : compatibilities.consistencyCriticality) {
			consistencyCriticality.format
		}
		for (contentVolatility : compatibilities.contentVolatility) {
			contentVolatility.format
		}
		for (securityCriticality : compatibilities.securityCriticality) {
			securityCriticality.format
		}
		for (storageSimilarity : compatibilities.storageSimilarity) {
			storageSimilarity.format
		}
		for (structuralVolatility : compatibilities.structuralVolatility) {
			structuralVolatility.format
		}
	}
	
}
